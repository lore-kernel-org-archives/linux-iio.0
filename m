Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569495;
	b=0ifGUWDXLNhaXOza7x8e+YITrhNRlQc3431HRa+AXGNJDOhL5y4nbamwUr3KmHyowmAN
	 oUVrpqXhefVVRhL2cmIDrz6Naho+zJ4fFX4r62ciTy9zPJcWKbd+DOHLBeXJTJha2AWFV
	 cGDhULQMxNTPx4zruHsrcKjag5QvllLKABxDjbka8UdQrq8ceNLscDVrpVLxiptiMV1EO
	 Yl3ZG9/Mtvwnh/qwHWVPSpiqT8ARvbRzrgmPyCAiMM9OaUbLR4wAhE+xRzcLYe5gb9vpj
	 WbAogpU77pRULtM6aXE+QgB+NcejKlamE6oFfvCtC2iOdbUOT4aDhj1aQwBsdNyPE3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569495;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/2FCOFkahv02WUb8MJdjoJ0kcL6KdukKsXu/EI6/Sz8=;
	b=o6P+pySqkxN2m5E/Oa902uIyqIqxpPqSGNkxs8Axab4U9q2S868QZsNAiOGqroKOCmRf
	 +eS4qGObq1WpaqmJmdQF8XPakVb1UC3dAdo7Nsnvrt8jgwKHWpABjboGeyyyojGi4zc0l
	 6JtL0AzKrGjcVVTgWHLdTORPf9RjHTrY1JcuT/5HpRvQkuHBq3Jetb1F/DMOvU4/IKccc
	 22gxvwlxU+jn0t4rZf1nAV8mB1F7t9huNAuttOyjLoLucwJeQLzeyo+EO0l3W9x1PhUkg
	 Li3JvUtF0s0uMBkXhtA1GgnPp+jiaX0bpaRws0A1vxk7vZuv4yod2aRH8rK8Judc6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JyRg4Okw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D3uxpkYD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76861606A31E
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 07:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76861606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JyRg4Okw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D3uxpkYD
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j7AC2411481
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 07:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/2FCOFkahv02WUb8MJdjoJ0kcL6KdukKsXu/EI6/Sz8=; b=JyRg4Okw2lzPun4T
	8MHA1mbvUB8lV51dPNLX6y8pn/PiWSA+2gtprbCZ4ZsY0hcPF9WdrIylI4CEjBQj
	D4a1erK+AX3S7vXeO+F9ogocVkMcKTVoReurMORgQY2bqMPRfnmGRjIb7r8nxL+0
	odkMimf7OXlLfXTtYjJ4pFg8JRObXLwVToiY447omvbw9FIjjWuGFKruwNOMY4PA
	Gsyt7ORqCGGaSa6bjH2Fma04fxolydR7ZA3etRiPB3LjzAdbuTSSTykcPyjRtlRa
	t4yWUF+1YE9prsDrdzMPGVeODP1X9GAkyqezqzTX0dCIbZLxZmcXrt9SlwpEZpmi
	SA9TwQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvc5va-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 07:58:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9179ef12a03so2615786d6.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792569493; x=1793174293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2FCOFkahv02WUb8MJdjoJ0kcL6KdukKsXu/EI6/Sz8=;
        b=D3uxpkYDAXpfUt2sshatG3/Al7P3389pCq6BNlVPmooJtnj3Xy2ncMMQy80krtq6x4
         RZ2LWKnSQmmZhhNV4xtAqyBXm3TpxuDSBbhLImm+p2Mm6WVLghJE3I9m6N/0hH9yyHWs
         MHC77wzOk7fWzvm7QiB2hpUJYZZbamU+6jJNiA7UYUjvd918XWupDjkBwjA4NWbXtxpG
         ykZl9B2MXtprCcS1n+O0B21Wu6DsxpMPgCpX7hFe8CyHonXu5SxlFjwtNjxw0Oh7S5QQ
         IthXjhssFTjQrA6HwxXLdUhg175rWkv5sX3xyZIKN7QMjBPr+OtUyHLFL7u/AVCf9TY2
         HVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569493; x=1793174293;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/2FCOFkahv02WUb8MJdjoJ0kcL6KdukKsXu/EI6/Sz8=;
        b=vy19ytEyDKMvuEMANSqjEkx1RFrY0lW0caQChg7Y+QtyUwAft1h6+cfjxUiU3wcW/6
         9MPxW50NEZX++bcKKIAqUgXP9AGkX2JRiekQNw9X/+oVgA/VJ/SHBBaf14mbadcPpAH8
         zhfwBstDucjlDdLbmq7qMV4oLebNLtgLLT48wcms0E3Pt/AaUdVzZF1CjsapcnaXkCOa
         gFzZM6tYCQjUHZ82hfW7FDxhCstM0CQNklEWPkhv2WEvZJtePGo9G11QTdh9fsbi+VGN
         6wVJeLwaLZi8GspJwmYFpYwV0lnm9s5zLEZDtxp1zJSHhoU8NeSKje+DWdOg9nxVj6SO
         7R2w==
X-Gm-Message-State: AFq9FYJONlxGgHRbZ7sPMAtyQAAptxxdiQR/29EfdjrizL7kJKSuPHRo
	MJQXm2Bijtp5V6c+3/74aCvAa8OzUc90Cl8Xjw6acIi/OPRVAbbpFKMqcHTkomYwpsV7+3tbDgf
	Tpn6XbPDJuauQR43PvWrJ9dSFthI8KC4Axh1bxsDMb/Vw5Qvx2dqXrmhJwtWiDN0=
X-Gm-Gg: AYBFou1HHjcMEXmG73V8Uud71jlHeHAWNMXQBM0t7qSylz89QYBSRlHLhVyx5hMNpgu
	13IgNEkaWV72OeTieZlee1tZ84m9fU/ealQ/lVnOhqIBR38uBy5/65PZ/Lzce6CMdeojYIz5Fc/
	NWASgwO3UZ0gm5uvrbHkI6A2MjOKATpI9e2TGIE19Uq4JDgqd/Lp1E7WYSXGger0gz3HQQ6Imj5
	jJZYgOx8sA4lTNR+rd7Zbgkb6NPzNNRvRbYOBAu0bN70RF5kEGBXBV/fJS4XeGHdaSVxqZ0gC4N
	XsTBzPUfQk+HPNxmGhBMVFrnjmrHGHL0KllZ44adXNUCHr2r+11DO/Xl6wa8jAk+rrjDlyQZ9Jd
	p61JGL3F5mCrnLf2zAwCi2g==
X-Received: by 2002:a05:622a:4c7:b0:536:79aa:de1b with SMTP id d75a77b69052e-5369ba1a2d2mr23732211cf.4.1792569492686;
        Wed, 21 Oct 2026 00:58:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:536:79aa:de1b with SMTP id d75a77b69052e-5369ba1a2d2mr23731911cf.4.1792569492191;
        Wed, 21 Oct 2026 00:58:12 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fe5479sm49671566b.64.2026.10.21.00.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 00:58:11 -0700 (PDT)
Message-ID: <fedd4398-e652-421d-8c85-b5afed0379c7@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:58:09 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add
 proximity sensor
To: Christoph Rudorff <chris@rudorff.com>, Linus Walleij <linusw@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
 <20261020-iio-light-gp2ap002-v3-3-b7e0946c9e79@rudorff.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-3-b7e0946c9e79@rudorff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMSBTYWx0ZWRfX0xp7+htIyNiS
 NchITWB0glztwcldGykxPtQJLodVRDyrXmjbCLO/O9OyGH8XnfiEQ4YlE6kE8WI8uQzJREgBWWv
 o5Ef3HKXXf9J7ZaoMgikNPjlhq1be4OdEBfJiWMnLUa8x61S39i9Wdzvt//e8x9fO0elxVCGf0i
 Gl36oPRm41vUl0dZfbvsLR7Nryi47BsfO4ufce/Ql2VLu1oA8lbzGMwRY80ktpEaammhOLeWe0S
 8Z+xmUmnCNypxkbDmOGC2QmEFTFfw2fPfsytuffOV0sWsM2fXAk1j8E711Acz0pa411E0a3Cyx1
 FsVQiyStCY1k96QyB0/JWqhaUnAzVTgsUoKS+yl5eEFCi1Nq0+K3D8jP9rtEOKHk+KhFBtn/9VF
 Hs89TdAaHAv5MXNDOXR10U/X36dCEjlrcWpkLs+JjJCs2QKjzHHLycFw04m/VLyJwIgWKsWsLie
 mMgQ4GirWNCWPYF+/AQ==
X-Proofpoint-ORIG-GUID: c-tWvq1KMfTL4TPCkNABkcZLkzZDu3rZ
X-Proofpoint-GUID: c-tWvq1KMfTL4TPCkNABkcZLkzZDu3rZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMSBTYWx0ZWRfX8nktccWg4BZp
 D+hcbTp09C4I+6S4Q4GdgKro69ooz4D5BaA1s2CbhURJch61WvWj7vJAZ0dViJAlaIOV2ZO4SJ9
 sHdC9MNkzo8rBtWlNRpn8WEpZTnnru0=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad87095 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qfT2Yf8mAAAA:8 a=QUAR2sPic8ULKe_pPicA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=nKa2voRIl820JbUdVH2x:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210031

On 10/20/26 1:35 PM, Christoph Rudorff wrote:
> J5 got a gp2ap002 sensor, add it and it's supplies to the device tree
> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---

I'd like for you to comment on my past reply:

https://lore.kernel.org/linux-arm-msm/5531e454-0d84-48f2-af0d-1ab34c149760@oss.qualcomm.com/

Konrad
