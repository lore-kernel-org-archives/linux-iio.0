Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE55213254
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775437661; cv=none; b=E0ZefRQaJ0QC6YB853G44zbnnzWEeeUmGiopirWf6nnrVBFD6MLtJEUl53Cdwg0GvrEkYvfaFDDudgeq09wGwcBIn1g4WzKnhfVDcr5SiVN32H+Iy9h1EjcFjq1q5AGvy2oZLCEvpYQT6K5ZpujWQbnPN+kf/EEAiKFc7PJqIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775437661; c=relaxed/simple;
	bh=MKJakbcmNxzxGdWfBKjHf0cp3wZmHZVEk+QzobVnXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfcDACyXiEK46KfAlVbS85SKhRcfchTmU+ZRWCs0OHt8vsHLxLRLeR5ZAABTieQpApZXkfLMccBoXz0GWmNgnUXZ0O0bdB0y0cS0wtxndJoieR5MjQIKUSekWbLEoSak7nJ777wG/DFNJQhiAxsvyT9a4bPwnr6zQeFWWx92TiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTPczUXI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G+44phnp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTPczUXI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G+44phnp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6353mQIs2832402
	for <linux-iio@vger.kernel.org>; Mon, 6 Apr 2026 01:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4f0uJli78TMMK8KUK88YYviB
	c/HliRox1MxKveOYlmM=; b=pTPczUXIatcGJMEZcoduD+/QPvsFTVa+j1eCGVQ8
	PH7VCTCjxNLeLEjIIZcBrRdE6h25tTMuaHdmcIiD9r8TIo9n12KVi17xaZgLdacE
	bJPBu2wKnp2QvfBKyYL9B8VS1k2zpXBTZUgua6n1SZRnEXYA+Lc6Sd51BC5HW1iY
	pVbGdP344h+40xMGxzg02ctlfDivc0vPS5xeU74VGZa+v+wvv2mVkJV9ajlyACs2
	becXaxwqiZuCoN1hvsvBM2gw7a8SJdVfElIBjA1Pib4hy0Ddfrp+ZYvHBL9/Tv5v
	vd7FZn67xzW48uqTYvG76TcWc+0nAEZIfF/uRklTjMNvqQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasyfkh6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:07:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d63962d83so78685471cf.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775437658; x=1776042458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f0uJli78TMMK8KUK88YYviBc/HliRox1MxKveOYlmM=;
        b=G+44phnpEZfuPJxkIGCMEy3RIEJR261f9N9o2/lw4dJ21MnvaIGY6v0Y/p7XIO0h+6
         Qy3lINdpO1cBFqZZvBFd2xwfO0Foy7ALjY7NO9uUVj/2p0YimZPlXkuEIOgzlKDBMU62
         f3y/+NSPZMHeom9SjYpH5JeTe29AVcDZSBJvm5nkLDRSBVNKps6qHnDdjf/DHt7Dt+BM
         82Vez80ECagMidU4Xj/SoucKjh6ZUBSxHd9wWZ6SK3qgIxDAtIPiOzEefGvDMGmZ01BF
         5a1XzTf5V3uaQvBdWR4GQMt1u8sQjrLBysoJ94vTzYBqx2TfkM50I5uPyUJKBRyLVwpr
         p4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775437658; x=1776042458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f0uJli78TMMK8KUK88YYviBc/HliRox1MxKveOYlmM=;
        b=Kf8cUX02UqMcUfMjwYSElppbyR5kpu/RMgN2uWFJA6+UudS0h6Vbvfvv8ALEUwpDj/
         tg5t06uC9JnD55Oc+Y9YIDC4Ef8G/HcmHWICR85g1QGrh4l6EmBD+i6aew8UpK5xsZMW
         PUB9Xdn2Wxtlu5rBi73guTzg78OWIVpO5YP7K8EzEZdFRtoOmmT9mPbp1qJgh5m9pWuk
         wyBFlPkIIuTNRuBKiTH9H2UzG1po8oXcFzLq4zqVS0deeRI8KtTYiYmyBUDdIFxseGwd
         IunvU2riKgtV5toUPR/o5vaN4iKGp7Xeh+AXsrD9xnrM7e/OVIPbcOREJjNULwdpK3/o
         nHMA==
X-Forwarded-Encrypted: i=1; AJvYcCXVKXo6z1/Gf/E+qT7k1EczzX4nLxgY2eJDDvS0P5TZxxVFsSeiePKcGWptCKMo2Z/1vty2X/ytNYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrlabgo/7Q7gNigq/WpzvB4AqmLsoXJhcWiGCxO7D1QTW+Xpf
	+ghKnnbdwi8tRAI652U3NDPCViXXFhYezufNqJnDt1eKaS8kwsuQpXrdASwru1f8sZPI1ml2Xn8
	L1M3aAvJUOCvK8cYqSry1jNdXMCL9jRMiAY/0rAe54aoz0K6OeocC+OLnz48wyIM=
X-Gm-Gg: AeBDietPbPqPOjP1K7XVxvVbaw0uCWOMxml3okWZ49VtWNJxOXZjoRO5AA8trPw4x7P
	vRO41rum+kZsxc+6CnSYEoLRwKxzoGPVfU1OMPKuE2JQsEN5Le7cCrirRdKHG34BJeGiS4B+Xun
	cQFUJZ3fs1EH/hIMqZrPMKu7xY8me9a7C4/iqpnZtn0E4rlVoIfugfh13B7lQzS5DowkKr3p4gR
	n8CKNacdaweNn2a1+hHgCvead9ZIobURIwjIsN6zSQIYPMf0GLgRpiZMI8IWhmw2jLlK79Ihq0Z
	u4iKf2d/K7+IHQKKOGQRbYOvnOWW5ZLYnnJF619Zcjh3wTMZ8rVU7gjCU2we7yf660kj9I60YHk
	oLpYa9AT2GdTCUmEm0qlVlrayZSDJe2D28Ki6AN/YwCyyiTjzp6UIYlEuQP1ZVlbxf71vyr5cBG
	l9rqV+a7lFmudwHq0QIpEuwcQ3GJG1vLI1yQU=
X-Received: by 2002:ac8:7d02:0:b0:50b:444c:e268 with SMTP id d75a77b69052e-50d62b4bb01mr180596601cf.19.1775437658535;
        Sun, 05 Apr 2026 18:07:38 -0700 (PDT)
X-Received: by 2002:ac8:7d02:0:b0:50b:444c:e268 with SMTP id d75a77b69052e-50d62b4bb01mr180596211cf.19.1775437658103;
        Sun, 05 Apr 2026 18:07:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd1fdff47sm28106631fa.13.2026.04.05.18.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 18:07:36 -0700 (PDT)
Date: Mon, 6 Apr 2026 04:07:34 +0300
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
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-pm8xxx-xoadc: remove redundant
 error logs when reading values
Message-ID: <ddxrfazpcyert6m5k56facwy7wq6hlji4fq2zotb5lfgglxzjf@djr3uwixhvi7>
References: <20260405-pm8xxx-xoadc-label-v3-0-9fe179c283ec@smankusors.com>
 <20260405-pm8xxx-xoadc-label-v3-2-9fe179c283ec@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-pm8xxx-xoadc-label-v3-2-9fe179c283ec@smankusors.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDAwOSBTYWx0ZWRfX1qsnZM/dYGhJ
 KnU/2LLJvRYhGBnmHwScgoLSV0ARguvJmVDI80cHkh1I7fazNFsRP8rKm5LEmlq5StM8lwx90W/
 Po1HIS2lsL7efYGolW9W+5O4nYMc/M1sXQMUqHY5DGfrZIDMi5PgzSRuBd9+jvpZeLH/j6VW/em
 NEpW+Mc5e1feKSkrzHLD6izU3wcxDJIa2LLzOSk2I7eOnMnvVvjchaQ46oS40jHrqt9YemaSvsT
 geWLsMLGXBciCZZWOHSArq/faqUtAL6uWvQ1MXy1D9nH9xjbg9weCkMgU6/jwtNRqASwqyf0ojx
 QvlMu/xB67TOKbMRvmupGibGv244wzRuzAGdom65nJSCHRQPuZIJCtBdZLt20DJRsiJ609V6/Zj
 +4EfZFsRyUAUJz/sLRAVG2f1y+FvJZhTv1anZmKNKmPW/L34qyfyhY/uW0cTptORL7bHQ6VwWWB
 yaGStmUTKYYG7KPVUtg==
X-Authority-Analysis: v=2.4 cv=U5qfzOru c=1 sm=1 tr=0 ts=69d3075b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=wxLWbCv9AAAA:8
 a=EUspDBNiAAAA:8 a=Jp7DWZVJ8eVs8d99wrMA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: 0O2y6QVRd-LgPoaU-63DzJ5JhpnSBdtd
X-Proofpoint-GUID: 0O2y6QVRd-LgPoaU-63DzJ5JhpnSBdtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060009

On Sun, Apr 05, 2026 at 04:52:18PM +0000, Antony Kurniawan Soemardi wrote:
> Drop dev_err() logging for -EINVAL and -ETIMEDOUT cases and rely on
> return values to report errors, reducing unnecessary log noise.
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
