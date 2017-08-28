function  [CrossPoint, flag] = validPoint(LinePoint1, LinePoint2, TrianglePoint1, TrianglePoint2,TrianglePoint3)
   
    %TriangleV ����������ƽ��ķ�����
    %VP12, VP13; �����εı߷�������    
    %CrossPoint ֱ����ƽ��Ľ���
    %TriD; ƽ�淽�̳�����
    
    CrossPoint = zeros(1,3);   
    LineV = LinePoint2 - LinePoint1;
    %-------����ƽ��ķ�������������-------%
    %point1->point2
    VP12(1) = TrianglePoint2(1) - TrianglePoint1(1);
    VP12(2) = TrianglePoint2(2) - TrianglePoint1(2);
    VP12(3) = TrianglePoint2(3) - TrianglePoint1(3);
    %point1->point3
    VP13(1) = TrianglePoint3(1) - TrianglePoint1(1);
    VP13(2) = TrianglePoint3(2) - TrianglePoint1(2);
    VP13(3) = TrianglePoint3(3) - TrianglePoint1(3);
    %VP12xVP13
    TriangleV(1) = VP12(2)*VP13(3) - VP12(3)*VP13(2);
    TriangleV(2) = -(VP12(1)*VP13(3) - VP12(3)*VP13(1));
    TriangleV(3) = VP12(1)*VP13(2) - VP12(2)*VP13(1);
    %���㳣����
    TriD = -(TriangleV(1)*TrianglePoint1(1) ...
        + TriangleV(2)*TrianglePoint1(2) ...
        + TriangleV(3)*TrianglePoint1(3));
    %/*-------���ֱ����ƽ��Ľ�������---------*/
%     /* ˼·��
%     * ���Ƚ�ֱ�߷���ת��Ϊ����������ʽ��Ȼ�����ƽ�淽�̣���ò���t��
%     * ��t����ֱ�ߵĲ������̼��������������
%     */
    %��ʱ����
    
    tempU = TriangleV(1)*LinePoint1(1) + TriangleV(2)*LinePoint1(2) ...
        + TriangleV(3)*LinePoint1(3) + TriD;
    tempD = TriangleV(1)*LineV(1) + TriangleV(2)*LineV(2) + TriangleV(3)*LineV(3);
   
    %ֱ����ƽ��ƽ�л���ƽ����
    if (tempD == 0.0)
        %printf("The line is parallel with the plane.\n");
        flag =  0;
        return;
    end
    %�������t
    t = -tempU / tempD;
    %���㽻������
    CrossPoint(1) = LineV(1)*t + LinePoint1(1);
    CrossPoint(2) = LineV(2)*t + LinePoint1(2);
    CrossPoint(3) = LineV(3)*t + LinePoint1(3);

    %     /*----------�жϽ����Ƿ����������ڲ�---*/
    %���������������ߵĳ���
     d12 = distance(TrianglePoint1, TrianglePoint2);
     d13 = distance(TrianglePoint1, TrianglePoint3);
     d23 = distance(TrianglePoint2, TrianglePoint3);
    %���㽻�㵽��������ĳ���
     c1 = distance(CrossPoint, TrianglePoint1);
     c2 = distance(CrossPoint, TrianglePoint2);
     c3 = distance(CrossPoint, TrianglePoint3);
    %�������μ��������ε����
     areaD = area(d12, d13, d23); %���������
     area1 = area(c1, c2, d12); %��������1
     area2 = area(c1, c3, d13); %��������2
     area3 = area(c2, c3, d23); %��������3
    %��������жϵ��Ƿ����������ڲ�
    if (abs(area1 + area2 + area3 - areaD) > 0.001)
        flag =  0;
        return;
    end
    flag = 1;
end