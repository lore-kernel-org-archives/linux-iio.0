Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAE33D501
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253466; cv=none; b=UKPQBne8dI/C/b8We0/mBMuthcnSzYDEJJTLm75eGvq9g4eDq59p/KuvsXOvZsm0fuyFrTCt4j4yGO8MZxPz5kok0ROVArAvEj04fZr6wAksZ2fg7GQtDkcivbwIbpQlHGaIuIkvI8hVwbHZ4F2JNkF6ihJ8QEV7zqxXKhV0uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253466; c=relaxed/simple;
	bh=DWUQGfY+cMmSq5aGAa4CP2kn/TKjl6cto19/qpaK/dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaUWl+L26UpzX05noYT0c10MwHWpU3QuOb/LG5zEwU2WMBrHbJE9qyLe8I2u6N+mibHzbRhWCZsm/2geLJVANFykLabfv1oGaFCJGN3nOoQmUwqH1zQBAsUQtyqkFTYhB1e+R0ZfmHNn7XvHhT7OfCpnSRhmppkXdLnF71wtiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e25j4y5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JKPWr358; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e25j4y5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JKPWr358"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633KMAFs3803283
	for <linux-iio@vger.kernel.org>; Fri, 3 Apr 2026 21:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Jdw4BMkuoysn1cjVxg2If+mk
	C6tX7NFjU3rzvor305s=; b=e25j4y5yP2KtCztyw/34lb/jeqSPu0VPVKkb1yw/
	eGc47dXqRUJhfbbse9rovqfxXHsQY2uCD13SxC5W/aV6oyoA0DfXw+3HphsXOah4
	TSaNj6/F5J5ydKOIxzldsnFM1zGmUYOpIUS0R7UDe2dzDaWr1n5swUuGTA6pNsUd
	6IEfE/LeeupyArgL2/nHxREhLPD3C/NTxeL88+qgq+R4WuGdbT+yasUugHNgTrBf
	KU6W7wg0Ve2LdpvWvU1XRtLEhOEqie0MeIFW0Ulo9m6nLcnSkadNbZfLTruaRO8S
	rSN264jMK0jsOJ4tlo7XmX2eppaaruQjKKCSdcsqHIP9Dg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dac9f9qmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 21:57:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d6bf346adso18982991cf.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775253463; x=1775858263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdw4BMkuoysn1cjVxg2If+mkC6tX7NFjU3rzvor305s=;
        b=JKPWr3589yuAycLWOiIK/AerTi3g2PGzg4JO/N4CNWxzmqXH/Oqa+MfWUiMia1urzI
         XoL2L6uB9vLIkIuA6hR2krBnJvfO9PHhR7/t7KcSy5KgfoWGQmdG4455iHjtRd3s/58e
         K2juRQtMIVmp68GNie2JvwT83bDDdauhYE+DKnByxpcFfu38onud+wIliDtFoz0A89wf
         1goHh6mo3tyf3OYJ3ph9xY4DLsLiJtgmsnEn+rKHtq1SgP1iAnl9R/sLCqapQEqblHif
         tUw4dazBp1PAryX0CvwcpkdqA/7a3fbAgfUD6C4ZXPv9n1qUt/PeyOmubOtmaRV0edvL
         YObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253463; x=1775858263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdw4BMkuoysn1cjVxg2If+mkC6tX7NFjU3rzvor305s=;
        b=D3l/LBhvccUvUUcFd7p3TyhkJrUjpTk0WYz0hHwb5xDg1vAdC2fSmfBonVLN+FlNMT
         sZFSwi7waWEPaUPfbNXgI9Db8N5KImlcY4mRTnH3Jrmo84ho6K5s/73xWZTdsEU34qYf
         pdNEyjg9v4gc71Sz8ypDZtsvpQwRMUp8VxFkhJEjmQcv4KXVKgAxHWR3aCBSdR3xIh/i
         bRWys6+PEJ339RUmXUC/Z3Ro/T+zypLjOTvEgPVnFQp332UyDdFv3RPVFsYsgJG1s4JZ
         cy9aq+jiwLiQkQ713z1SsfIQV6C97G0/IFGSniCCKQ5/SUHgWrfY2EBLxbCPdRbZuNCZ
         mXow==
X-Forwarded-Encrypted: i=1; AJvYcCU3Mw5jlcKqxvoWWAg/QzEj2LMWGcr2AbU436jk3qTs/L4Hf3YHdG4O8Tn4ePgSqJpuL7xw48Bygfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIV9f7n1ZStEw5J1r484b0Sj2rqVFnwu3CD3eWdhm11f3D64l
	w6kfisvZGYMedSP0w8uyImRELcDlgYlXq24q1auiB7uwUOOIsXCTf1gQARYyNjRAiz/5yegkgBI
	8PZYLO+RQqgQPDlpyIRR7ZBi0fb/gZAxjlediJjqvoEz5RzrWJJ0b6vVcUIFhI6o=
X-Gm-Gg: ATEYQzyjouJ2pUXr3latKpBdNcJXTIEwFneSvNdG62A/2Ft1T2BWjlo7EoqSJk1Dk/w
	1FO9Kb9XHkN5p81G6vpgeZun0G4jrGJrfwc/Qa7gBQinsKSgeK2KF8aSoUrtzT+S7EefFIBzJkz
	Q0TKcgbJiVPFndUSWtX0WZQs/11abG90Qe/gNwfIiuzqJkeDq7k2uLnftHuvWkY9q2lLxDUpXF7
	V5nspjIXqnXWmElp7lHBhVVuxms3V+vGyJjmltUm5OOZEL9GwIf7BHT3KVljqhTFxw8DdbUujwx
	9lXm9fLRwPHL0Ot45P+onTBKqsPZFLuQMNTmhCQOi46eOANlMe/is/CNIZMhlNXz7Tr1qPmW/5K
	5x/BjZn3bhgrz3tVv6xBF/8RtIY1nT5VCNyzOMBRa/tgj2PmJFt0luOEtWvahzLGsQK16PVn5c1
	bOmZU9wbr8ObdwywoUbkQUW2Eq5nUqnwuEJa0=
X-Received: by 2002:a05:622a:5810:b0:50d:5d96:568a with SMTP id d75a77b69052e-50d629be2ddmr70828561cf.27.1775253463250;
        Fri, 03 Apr 2026 14:57:43 -0700 (PDT)
X-Received: by 2002:a05:622a:5810:b0:50d:5d96:568a with SMTP id d75a77b69052e-50d629be2ddmr70828281cf.27.1775253462713;
        Fri, 03 Apr 2026 14:57:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccbecsm1677937e87.62.2026.04.03.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:57:41 -0700 (PDT)
Date: Sat, 4 Apr 2026 00:57:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: qcom-pm8xxx-xoadc: add support for
 reading channel labels
Message-ID: <ahm3fz6j6kbmqe3p4c5e4szkbhcihtgxaj2z6k46kiiit3qrik@wvmbg4dt4l36>
References: <20260403-pm8xxx-xoadc-label-v2-0-29b50bf821e6@smankusors.com>
 <20260403-pm8xxx-xoadc-label-v2-3-29b50bf821e6@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-pm8xxx-xoadc-label-v2-3-29b50bf821e6@smankusors.com>
X-Proofpoint-GUID: 36wVLPgw1f4n0tDfRJAmiq0XRvsFzkIE
X-Proofpoint-ORIG-GUID: 36wVLPgw1f4n0tDfRJAmiq0XRvsFzkIE
X-Authority-Analysis: v=2.4 cv=BO++bVQG c=1 sm=1 tr=0 ts=69d037d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=wxLWbCv9AAAA:8
 a=EUspDBNiAAAA:8 a=I-nygmCkc1d6-4TqzFwA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE5NiBTYWx0ZWRfX2NPVsSljq+Ij
 zRGfH1P/SeqN8aqZx7NqaT1C7um3zo6TQTeaazGQ8HcL0j+WXT6HtfY8eme/Hio31b5sOW0G5WY
 5kn24vrUe9dkwUK44Uhy941KQWhQM9CZueN5vlAbXNQ3SF4/Lvfiv7YlwgOCh/u8+wzZH7+6ckB
 NR20GZ1HtdLYga9FCPHUE//l9Lfx/0Ed9N1kIyS0DtKKb5T8DULmc8GV3R3TFaN5/AJpeE8ejo1
 LQqZ8hrkjlEDGAGuhbzQsa9q1PcbbGV5wWuusQ39y27DpPI6uLc5EePWMHoveLMjzmGhHdk6due
 oc79LNrU+I1MuLY9rptTDxgC2OpJEsfWfkICSRhRK0ZI9dRW76+9puWcsBFpH7fA71V6z7J4yUO
 fDA+nZMhlRAL6AyOvQl7b1OlkH/tSXfiXqLHyqrIjK59sAfyo65J3jJWbSvuKjp59POC9UzYvp/
 uwApk8r2OKBF+M69xwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030196

On Fri, Apr 03, 2026 at 09:23:21AM +0000, Antony Kurniawan Soemardi wrote:
> Implement the .read_label callback to allow userspace to identify ADC
> channels via the "label" property in the device tree. The name field in
> pm8xxx_chan_info is renamed to label to better reflect its purpose. If
> no label is provided in the device tree, it defaults to the hardware
> datasheet name.
> 
> The change has been tested on Sony Xperia SP (PM8921).
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
