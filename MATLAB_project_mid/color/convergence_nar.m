% ���� ���� ���� ���� ��ȯ �Լ�
function flag = convergence_nar(convergence,iteration)
    % ���� means�� new means�� ������ �����ϰų�, Ƚ���� 50�� �ʰ��ϸ� �ߴܵ�
    % flag == 0�� �� ��� ����, flag == 1�� �� �ߴ�
    flag = ((convergence==1) | (iteration > 50));
end