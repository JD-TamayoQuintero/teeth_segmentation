function img_color = render_link_image(L)
% render segment result
% L must be a link region map

num = max(max(L));
[m,n] = size(L);
img_color = zeros(m,n,3);   % ��ʾͼ����ͨ����
img_color_tmp =reshape(img_color,m*n,3);  % ���ɶ�ά�ģ�����find��������Ϊfind�ҵ���һά�������±ꣻ
for i = 1:1:num
    img_color_tmp(find(L == i),1)= rand(1);
    img_color_tmp(find(L == i),2)= rand(1);
    img_color_tmp(find(L == i),3)= rand(1);
    img_color =reshape(img_color_tmp, m, n, 3);
end