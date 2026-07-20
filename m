Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869202222D0
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511668; cv=none; b=Qm/zfP0tFq4OyLb+OymVHZANyOkUyzf8DEuSgYMAh+3pB1XQ4SMbQBiGA6k+c5THktuPNMJwf9pc+apjNaPIXHN5MH5eKm4xdpbD2iW8eLg4f7mf3v8NPHTXi+Ak8riIV++Cvr4z0W+SPUAu2495SPSGIqaoNh8lMXf1U7MsToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511668; c=relaxed/simple;
	bh=JrOv9dhs52ssTF+KHBKQXjVSa0+A2mWnyvWkZnjbJqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quclwNt+aDd8V6U3YJUCW3MqCdSXiQ6XKrJqSBqCMXEezgpitr7Sb0+ZiTZo9GH18mhhcS/xQHyE7SvimHgJqhtmgsz5CWKja2ybom0AlQ7rR0WW2JNTRtcp212sD9EAUf4RNKb15vVSCUpeP9eR8XDdlsj05J+W82ntz7KIfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YTAVbh6j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJBMXo5g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YTAVbh6j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJBMXo5g"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsKRG408174
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9Z6g5fHkujzAVt4hRZEPIhoLNG7GscEXCwnXq3i1EQ=; b=YTAVbh6j3Kwalp06
	YeG+CaD5Kv4aPcv55JPp447+HP0s70t9N3tP3HCB0NMON9JJAQCsR7mMOxXTKYji
	JhS4xhr+E+V/bn/Jqw0CPcG1Xz/idqUx/pSbA8Q5ZbFHJ8n0hvq5aos7CKRGcKVO
	eA7ZZkOuyXVxTX+sYvA96rKyBx+oBcSnE7BhFnd1LwFWGzE1EytclZsHyu6CkmIg
	v+3Qibq+xvwQsz3PQKQNXMjf8uZKrB7VNnPrX/VSyrZL6/niLQeyUCCae3Z4ACus
	hBon2DaNmiFtCY1UZigMw6CwcKknjClkAdJFAoQz6uSZvmRalUMj2vFqrnqM+D5b
	oj/4Uw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhkvjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:41:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso12016335b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784511666; x=1785116466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9Z6g5fHkujzAVt4hRZEPIhoLNG7GscEXCwnXq3i1EQ=;
        b=MJBMXo5gY0eNFOfO+J3dkiW4pcbYvAywwdjhaf/8/X81fv12tGECkxpwsKUa61KYnu
         fjqrcyCaBeZfVbmOOEiORc4VQuK/S/bURFHzN8X5V/Jftt2s+Tsc0qmPFRGpGpzv6uJc
         HAVtLuKf37cTLsBIIvmtDZzyGC8oI0MBl0hXJXC9imUAXEnBOBWRWxCBNxftkNOvy8/p
         IQeFjU5QfLoolsSb8d1oyDFiqOCUVLxqiFby2NiMl1PKS1Vl+8N75fFbOW+KDF+0fK2W
         BY3VkNJ1ARvRrn4tKMWoe2L26J8sMcbDddOrINMpLY6svRHRZ6PbUVFE8Xc1JU+U5Bru
         b5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784511666; x=1785116466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9Z6g5fHkujzAVt4hRZEPIhoLNG7GscEXCwnXq3i1EQ=;
        b=hD/QZ7l6LhRMe1LRX1OZzH2JXB4dqAKRdFsFzezE7Q9ykEN+md1s8ImrVcKU8r7X/j
         3aMpIMG1jAF6yctwmzCDkslH12FRx1FAeuCKnutspa+YdYvSxxfH22cDyFqj/0DDnK0a
         +x3XSp76J+qE6UNLJEW939ajzFwm1GJma1ZYGkURa+fFWVwKhvh00XdsJv1yGDThwgMy
         W/2HpgyDXNp8U/Y8gobyXPU2vfUe3apC0Cz3sCO45qhehEFSZ0wxm2eGs9Mfs2E9v3Ow
         OIcyYM6rIuQ2eQkXuTfwz3VNYZBLo7zMCkRC9TRWyta7AZUGyRAtUt8n8luMH0u+Rvt4
         eQFQ==
X-Forwarded-Encrypted: i=1; AHgh+RortpYqXGVDMOVp4czeR1KlyphiFrrUXq1gY8IsZNbvCPuE4BdD6F5bJ9LOmqGS15rvI5N3A+YOvZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXX5RAyhXgBKwiq0IvcmaVfPo3uvMTYLP/iRhiodTdUk5VVUQB
	XfCmtCS1QlA77delbxF4Cx6C27ogZZrBDcWREXDgOS2OGLHDBt+v9Pn3tHCZtaLX8rU/Og1DaqM
	ATBt3vFxic9R5pstp8G3xHnMrVgx2kWZE2tjqtumfRsHEeEIDLHPGSw5s+nzv1xo=
X-Gm-Gg: AfdE7ckzVnl3nrw7J+qD9hq4U6Z0Gn+VNmGkfJdnj4zWfs+B/ktteqpTflkapmvuolH
	UNmy9YQNnSS3gqwQAS6meTyZQSeKC9bnEr90NMTCuT9UvsaQs6dmf/oSAKnYFrK5hEmJy59Ad56
	SUmmDvGh1X5/FZpkPIkoaYXKXOYWprvDmJ65rz0EDbz8i+PXojg8qwqg9TVfLrp6sYunbKN7JMY
	wDWJcVY1Ibg+2XU0W/yVgQI0VmkIp6trcWqRgN/QTgm5q4EV8V4Y/9+JDTAQlRMmcK4qaRA6vqG
	RMYDlpSjoBwoNcACNfWWkQ36/kufPGdKY2jd5dFIOB953yUKsCKbcQduXF3ka/6QaSIFrX4WMNA
	qPqWfMF/X0RVG7wc3
X-Received: by 2002:a05:6a00:9aa:b0:848:2f77:e2db with SMTP id d2e1a72fcca58-84c2952c402mr11255230b3a.68.1784511666008;
        Sun, 19 Jul 2026 18:41:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:9aa:b0:848:2f77:e2db with SMTP id d2e1a72fcca58-84c2952c402mr11255201b3a.68.1784511665486;
        Sun, 19 Jul 2026 18:41:05 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9f00bsm4748486b3a.56.2026.07.19.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:41:04 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:41:00 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Erikas Bitovtas <xerikasxx@gmail.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: light: vcnl4000: make read-only const array
 regulator_names static
Message-ID: <20260720024100.42a0f6b9@jic23-huawei>
In-Reply-To: <alZsXBdAJEjkpKZR@ashevche-desk.local>
References: <20260714165740.186119-1-colin.i.king@gmail.com>
	<alZsXBdAJEjkpKZR@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5d7cb2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=QyXUC8HyAAAA:8 a=lXELxFmDmW-935DcFO0A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: FyNKQQKSXHBHVrpNkH7mz0wUAp-50e6_
X-Proofpoint-ORIG-GUID: FyNKQQKSXHBHVrpNkH7mz0wUAp-50e6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxNCBTYWx0ZWRfX4iXFB9qKz4i3
 +JKPiqE0DDlxcfXa9uOW1YjHgWvgmItuppcR+cU3q0jexNsmsaxa3/+/VRJfG15MN6Ebw2MjSlD
 DmJHS1oynWXjOrVPm9b4i3GOfPT0hinuWLOXUomdxd26aqWc75yl6RUm0xlVqMsitvYAkCLJC+7
 YgqJtbqa97+5LM4sc58NaUae9dX/mF+B8eIbyRunwKHfA+vHyjB1denJzd+5r5FNQNgzamsuaaH
 eZGOKc5wEFk/7bBdUEbnE106uwQ/JHkBTTq9ACHrUMARxJVYLb3W28wzEtl6/tcv14c4wcS2WfR
 mElD7UNxQILDzNdX9IkYApbZfwQ2iMWVHgfxcn6v/+ugvD/0aCVFjKkgpDXlMSUFtOCwxvtm7ME
 fjMME3rtZ90L0x7dscxlsW2hK0UUrXV6sLLlNaDs7wcCkAjHUkwW9V2RQmeY/EQSIYiDbpqhhK5
 pCUGzjwiVDTqmwkWpug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxNCBTYWx0ZWRfXybVDFOItNQ7m
 19ffkW7rxhb2NcMOsRWOViboX4zxggF03KCjhnQEiYD8ZuGNnxPkCeLxGOihCy4y5hJvx2HH5Bk
 gged+Y9YmI9aNgfSJiCv5/cnSRA3Oqc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200014

On Tue, 14 Jul 2026 20:05:32 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 14, 2026 at 05:57:39PM +0100, Colin Ian King wrote:
> > Don't populate the read-only const array regulator_names on the stack
> > at run time, instead make it static const char * const  
> 
> Makes sense
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 


Applied.

Thanks

J
