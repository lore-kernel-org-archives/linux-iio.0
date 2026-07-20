Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF12773F7
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513746; cv=none; b=C2ectNjYXDGaYWMq8UwoVDj+Ym6n9PB2t6Xjj5Ijh7eZneAyIN20TByED7cg6TWIykDHIbiPFqs3Qp97L8ZNlaMfBDxP9q5p+qKN3kSKTh2U1mmqvLALb8i9mZ1tDMyLXGo3wMZuXov86xk3vkN2qbBpG5Lw3Dv7Cmnj66T5LKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513746; c=relaxed/simple;
	bh=f4jPhbz+0KYA3UwyHvc4TWBKqapolx4Mm5+ZSJFRp7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNPQNTqWZ8LSCg06bqex0kbP4dHI+W3zjWemFSg7EyXJqEEnU7nfFASL017b8WJBIg9FvhJYRvSWbVYqcACGnuAu0iK1xLy+DrrR0cNzHvmPQdgXNulilQOTH82x9S8+BL4LnO3sZT5vSQH6st6W6AfRgNm0FaAG1EzkOdf7pEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXvDlJAG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hkKFULqE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXvDlJAG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hkKFULqE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt1F5757341
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	muMynJ6X81LkXpxsOhRdep0638Q3LCadnQm4pDIBZ54=; b=OXvDlJAG4u9f57sw
	WyHXk0zSPAscmCDvWQwmeJH4QuUuFVTXm0YiOHw/3+21ktP/tMrwq8Hy2szIq6UG
	lunmL2+LK9nDv11OdshxURAocZ8cHRfT45kriS1q3Xtzyk/gxm2vQ+IUlmPMasQ8
	lIylXT6fhqR0NlbFkoPc69gR/GtuBh1BLcHzTODD7YLzOb6P1W5WH5ebLfcj0dft
	qtzuDlKrAjJBfNumdqt+eOOMFF6Blu2OanZvaasd9hP4PkOc9Bz4rS1G3QlOWEGd
	DljrK48rDCJV/gc7cK/+22wVAKDRpMu7lR1m9SSWtES7nb+f64iq11BuCrrMmb+O
	sJc2fQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnky56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:15:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so174608535ad.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784513743; x=1785118543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=muMynJ6X81LkXpxsOhRdep0638Q3LCadnQm4pDIBZ54=;
        b=hkKFULqEV+z+Xl56NV2wO/4Pq9HA77OcbaJd6Iy5abnqxPH8y/l0FK0pjWzR39yFTc
         nB7B6cPxzHGrQQsieoxMhHaSHD6QZ8iBG7rjIEhU7DMep/DaqzmFjnpad4RXSACUsIPp
         r+S8e8qvSRkL4NuWhYKqDM6MXnl6oFFfpl/AoL7kzu6VBMsGV01M1LTU6cl2IF6wIuxx
         mtBMILy6bPFmrjeML/vqKDxR824XQjBaXH/F5uzB1F3WKJIbohh+cChbfHkOClV1gZg+
         BLojMtfUg+ZQ+bq1/VOo+CI1O8qYcOTIpHBPKPj1jXNMJOWb3U7jkIPmffw5t7cwEU4n
         R9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784513743; x=1785118543;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=muMynJ6X81LkXpxsOhRdep0638Q3LCadnQm4pDIBZ54=;
        b=OEbLvoIxlAxsn1k0VWSI83hIgpEXOulDwlSZCmHuqYjHu8VYcON0a6GwUPn5D9ltMh
         zyA+mFiP2im3xwQ14AHKPQhoO3OLr1KZ1wsTA4eKV/JldfdQuOhT0x8GhzhOjBGv+Emr
         MsVQmI6d7XtC32fSaJjxSOJgzuYAXBf7Mpgdc7ZFGcB4RZQKrnP8e6NbCnor2zOmCtxV
         sGZGUn+xf3L1dngAYMHvmpUudRC0SY7gNXx9vUOnWh2rcqEFWJHyUrN1Oc9HMlWR1/96
         OoBi0V2DvJHLbHQmAe7PmcIuZzIOhiOWVuqEFvDht0TGtpm9GWcShR9RPFAlget2iC2d
         uW+g==
X-Forwarded-Encrypted: i=1; AHgh+RokYoAqYs1c2g2rMb01CfWSti1B9RvUM5fCLnsRnv//KHq05Bm97qzAD75/x+vN59psw0k535mTTHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0X/O4tUuD6eiVlR79GXVYeZDE85XQ2BmPpZoLybEOkCoMOp5
	fZ0Vq5+iZqDMqfvrYAO8kjTd6gJ9DOxhdTbjx/MiGXzf+chrlr3LRwfxcchH1PKNtGbEwOTyI5M
	AQAgGl1gPNM/F0aEMGA9K5lnLeLAkX3nmbsbwVl9Qw7xvKfTA+9z96jE31Zh1AXc=
X-Gm-Gg: AfdE7claqetYkW2TVeO0Mky70/13/axzkNIaRoSWiL69YN0gg+uK7wnDKklbTB/QEdc
	Fh8uMyPDX73SwqZAuI0AjagAjmL+C7uM0cicx5BGYHHgAnB5HXAKKakAVhByOGIbVmBO0kEyYQw
	zSbpz0T1+AK4xpsfSZo917kg/YueS9b/F6/ALhjt8tZGj7LwAJZo34j4JyTm1rhY7cAKfgxTpNO
	9/oGUhJMVE+ueIK+FGoM16wGB39m6WpxiZjF7qCULZBAmVFtmoTnILQT8XPwuCassAcoE1Vtw9K
	DTH11udyAf7vf4mlVjsdCuZMXSBJmvlmjvCiB+WSRS11dLkx+7aix9JQ6UEC7MGr67c1EQkImtk
	5ojXDibpLWX4LHcCJ
X-Received: by 2002:a17:903:1b24:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2cf3486100fmr135692185ad.11.1784513742725;
        Sun, 19 Jul 2026 19:15:42 -0700 (PDT)
X-Received: by 2002:a17:903:1b24:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2cf3486100fmr135691915ad.11.1784513742260;
        Sun, 19 Jul 2026 19:15:42 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344d80e6sm47281445ad.29.2026.07.19.19.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:15:41 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:15:39 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kxsd9: modernize runtime PM in read_raw
Message-ID: <20260720031539.19614d52@jic23-huawei>
In-Reply-To: <20260714122520.3201-7-birenpandya@gmail.com>
References: <20260714122520.3201-5-birenpandya@gmail.com>
	<20260714122520.3201-7-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: APDPejFOpCHxxfIBCxvyp44EXzotitml
X-Proofpoint-ORIG-GUID: APDPejFOpCHxxfIBCxvyp44EXzotitml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyMSBTYWx0ZWRfX8SHJvxqY/JQQ
 L0rJ9GehO5BeYuUNufz7KoeZ1b8fN6nRPr9/Z7cINIv+gTbNykdCnoEBiVvkvdC8+oXP2vKynbH
 AQu28I1dyuBP6ro9VmSLOGBQLRTZlr7Ty+7HWPNwVx7B3Pt6YlaH6Oy83iJWXZ8Wc4sPjC+rsN4
 Zn36UmKyHLsuHThMVIRRr39FH2q1ewaqCWIJv+1WeADqOOwHUFJjhtM4A7Aq85himA+HjOn4+PB
 VaOT60P5tvEYDeVPouqEF2RXLFwn+Zl0vBhsNWggApSk9QUgEuCFCJb5trreIIMbspx+rfE5nvr
 oWrBo//nWLt1/PM28BazoNucawQ9ISStbGbtgUvt+muE5m1n8vq54/1w+NO5dMH8V+HjPdYGset
 kGUF11E4uhd0MB5GwuBPLuj7BDyjbXXAKmT99EKZ+y/DXdqaz5wPmLnfnUYl4TAUXHipnixf4gD
 5luCwlHISvglbHkxoCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyMSBTYWx0ZWRfX7Wt5PyBex9Op
 6yxKFf32c7LC6K0XBpRS+0xyojpAQMFvZXlXpNI+cLfmbEeZTlChJOgNkzLOc2QFW9NJ0NDY4A6
 JsqDzZGLxMe3+z3Y2chXwXooW88GVuE=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5d84cf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=8o5xMLkJ2mGO_vE6C0QA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200021

On Tue, 14 Jul 2026 17:55:22 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> Replace the legacy pm_runtime_get_sync() call with the modern
> pm_runtime_resume_and_get() in kxsd9_read_raw().
> 
> If the resume fails, we now correctly abort the read instead of
> carrying on and reading garbage data from the sleeping hardware.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
>  drivers/iio/accel/kxsd9.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index b3acb20441d86..680d43135e617 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -164,13 +164,15 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
>  {
> -	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  	unsigned int regval;
>  	__be16 raw_val;
>  	u16 nval;
> +	int ret;
>  
> -	pm_runtime_get_sync(st->dev);
> +	ret = pm_runtime_resume_and_get(st->dev);

Look at PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and consider
how it would improve this code - particularly with respect to
getting rid of the gotos.  This function is almost a text book case
of why that stuff is useful!

Thanks,

Jonathan


> +	if (ret < 0)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -199,6 +201,9 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
>  	}
>  
>  error_ret:

