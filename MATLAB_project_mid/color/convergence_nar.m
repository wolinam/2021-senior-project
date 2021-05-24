% 수렴 조건 만족 여부 반환 함수
function flag = convergence_nar(convergence,iteration)
    % 기존 means와 new means가 완전히 동일하거나, 횟수가 50을 초과하면 중단됨
    % flag == 0일 때 계속 동작, flag == 1일 때 중단
    flag = ((convergence==1) | (iteration > 50));
end