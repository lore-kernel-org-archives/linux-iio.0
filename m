Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA33033CC
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416392; cv=none; b=JWHFjWEvz9ydSp54Ybt2U6mD429VG6PDEzUe+L8fVujrIhwXIZggC0ZndXi2iqzNP10MxyH9hsxd7jgbu0Zi6moaLVhxOp2JDSeuHsM8vO1J5n2eClJ9311u92lr5gLfdZPtsLZLL7Q58lZm8BPuzHcR3HDyXGmkws4WgI9ezto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416392; c=relaxed/simple;
	bh=XfGCLLxXumq2OG+cXSSeTxfYIKiJ2l0/DQerjf4QqeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZliEXOeVmUyPJvTqZhdFMDoQ8A2mjrxLmGHWZLGE/e2qhqblFk1HHhmM74tvU7oAK/M9Bg+2xOgBUfGX4VTOxfoQ5QJD8HxsvuKMRhG6AAKnhu7Kebv/cAjygoXtvkdusGXmi3GFzcF1v3iiiSngEsuBlK+nQPFW8SofBYqAhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3Nz1++U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X/gWpX4r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3Nz1++U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/gWpX4r"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN2Nvk3059596
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkVRv45m5ANrH+FRuh+llStt+cQykEu8P33VkdTcs0w=; b=l3Nz1++Ujorn7GhG
	2sDy61Sgsj3Qowa8ZZU3f7p8ZcyEPv+GpgOVBd0lmDTYui6zYfjvMhu0BCdPrP9x
	tcDFG9+su8B+lcKJ5r5tOjZUpisQQTgZSijghhQhq0SvJMSnzd/z0lc8dD4LKnrh
	pPRNQu2JaCckG1Pt4fXlPbCSmP7C73TFP3oWRGVBGb/tavFzX5+B0Q3V0Vs8hosS
	7ryf5RnW38kM9KnAPXEhaVETRacRZc1RDpABToMlVH2E7GUBcO7fBMW1If17Xx4w
	pYD2u03+zD9jn9OgkOhYtsuorq64LiVNNoz0ANA0oETcpXd171Lc2Lwcry8F2ghW
	J4W1Sw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aasq90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:13:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84859a64079so5162045b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784416390; x=1785021190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VkVRv45m5ANrH+FRuh+llStt+cQykEu8P33VkdTcs0w=;
        b=X/gWpX4r6FWv0Im/sa2oO8/qu/JvUuhZrtzdFp3rjAJfhFlD9GDVuhpbwleCKjbRja
         D7Y+x45Cs82E+anqHBTru/v8N5F52UTDRHIio8BJluMwzBHuDK7nlENr5PDwJZiA0Dak
         qJ5f/EKz0mwXkHMQrr/6A7nkGcTRKC5uuqQ9+Jx834WI5rT737A3n5WIE7VE4Lp1PqCA
         1iGWi2OJ/q3Ux38xXihv7NjyUi3/9ZGKmjhLSCN4nGUtBJmtk0eE4VZQumJu7o2UpAeE
         R7/j3cCz5G2irC4U7uDkIzcrKJk9ydXxjWvKxhvhnoc+qOsOw3bSEt3QsmsDIgSw9SrJ
         b+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784416390; x=1785021190;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkVRv45m5ANrH+FRuh+llStt+cQykEu8P33VkdTcs0w=;
        b=suVu+pofJl8WHPQ9onDHEMReMQJ+dtg9bkRnPi/SWndHn1x7A9mmGApPQBseCpw7Tl
         LDBMysFhY06GGbiPHDwe/MsxPq7iq0uPGLv/cMUO8QPuEHqJ6iaXiZhWkSD7oRU2VSAg
         5fiR80oMGpviQQdF/9I52uJHuPoWXAQlAMbp/+wRKlM9TLGySg72yUUTdJurcSmlo9X1
         aJmmF6GukHdiTyOYjRBdbdPF8w4rQPd/c13igJdIgSR43N1+JJptbvvJqwUMobmOiN9R
         tYnqZ6T1vNI4Wcv3QL3s1cQavwe9O+UvtOte1uLFxyoMZBBVUaXapnWzqWQEyGuGpydF
         fn9A==
X-Gm-Message-State: AOJu0Ywibr3hfaozqauveiUGa1tSN4HslUOqF5bM/R7FOz2NRKKqXhR1
	QJ9un0LfCcC5MDuoD5/P2t/5EY/0mAkUSidC9MuWSzdDQBF6PicSxa29iWxjN2IST2krhNa/fMM
	qUXYupB7QBAp3Ls1LPVvz2e96207BdkoZKT9q1eccJB9sjDL8Vg4vah1n+WahmJ0=
X-Gm-Gg: AfdE7cmqWMBe7RrwZ66BIYKJ+OdDTS8l+/LGDNKXq4Lnc+NWBmkCvykoGGDWqkkA3eE
	OTWwgpOnF/Kk4kfDEYo6rHNoJS6NJ+WgnTNZHb6LLwjrA6uVNnIGE+mHIwF/lK9iRw79L3BZZmO
	IWK8rjwkfT0hunkizibEuWIe7ESqeMIC/1hXYfm4DjWZAskNQ9Si0YXeZtxf4I43x9v+qhW9Mu0
	GLu2u3BncPqSfEuOgxS4/vbRf609juWwOU8E3PDoWFHSDAYWoEtTdc9A6F0KVjkiMoWPdiR9iV2
	PgdWLejuoJM3/+ZKeiwKGGhdE7bUbJ4cxnsiDp6PSYdLrb6ptfZ+TA7xXWLVlVvYAT0sf63iv8/
	+w752wSYqSMk68ljJ
X-Received: by 2002:a05:6a00:816:b0:84a:2c46:3fdb with SMTP id d2e1a72fcca58-84c2923a051mr8853200b3a.5.1784416389746;
        Sat, 18 Jul 2026 16:13:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:816:b0:84a:2c46:3fdb with SMTP id d2e1a72fcca58-84c2923a051mr8853168b3a.5.1784416389335;
        Sat, 18 Jul 2026 16:13:09 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcd3d1sm3249794b3a.22.2026.07.18.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:13:08 -0700 (PDT)
Date: Sun, 19 Jul 2026 00:13:03 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
        dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V17 0/9] Add Invensense ICM42607
Message-ID: <20260719001303.422cf24e@jic23-huawei>
In-Reply-To: <20260716182637.24310-1-macroalpha82@gmail.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AOL-HA4kQ4xtZhVXJpaPGND0u-K2HUIv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI0MyBTYWx0ZWRfX8rvJygwj1wUN
 QmY8J+yY5036JaOjxNh5DAnrfeZXkCqvSBDE7ukqBIPxvlwRSWf9wpm/2frJL+eLhJ2XYhR4LlG
 9I9uaMRYtPiighC2zQdghxrrtfFkE40=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5c0886 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8 a=hUMHPH0LmMywwkxqrTIA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: AOL-HA4kQ4xtZhVXJpaPGND0u-K2HUIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI0MyBTYWx0ZWRfX9ijqQVgxk0CA
 +DoDO6f9lhr7niVG3D/SIBEERRcZE+iBB32Kl16RWSIZ8SMileHiUJlwya131UFfRB+4I65vyLQ
 +yIIWjWtEDNVzvVdmbBt1OSYQr3a8s7YrnCpI0WaqzkLo5WWEPR6ZLn1Wv1kuLiZ+QEce3dLC2U
 u4CroyxcBxrY/0o/hZGAFaaG9mv5DpaRRgdwkH5LM/5al4Gk6dAwXkaa3OhkbuDRc+t/BaKrKAT
 rqGOqnR08jy6LekBQSAwzRR75uEv3B/E4IT6hb83Wr4YI1RdhjyWRgsBqSksuhK+93b5zsIlvQQ
 QpX7/qAI3YH2p/EDSVn34sUXaPD3Lfo+nD9mT80YffiGfHYkPHHTS+HNRjVzk1wXrSxsL4CtdTE
 DKAUyNmXwNpnFiSES0rJ/13hQO+wg92h+k1LruRC7T9PyVw/i4vTYEkh/O30DmjAGKbxoR8w1bt
 Vm9R4sUUd9ds4I+/Fxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180243

On Thu, 16 Jul 2026 13:26:27 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the ICM42607 IMU. This sensor shares the same
> functionality but a different register layout with the existing
> ICM42600.
> 
> This driver should work with the ICM42607 and ICM42607P over both I2C
> and SPI, however only the ICM42607P over I2C could be tested.

Looking pretty good to me.   Just that sashiko review and that one
minor think I noted + drop the header Uwe requested.

Thanks for persevering! Jonathan
