Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DFC28690
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784507731; cv=none; b=CaPWnyxhWCboFFsPTgvIb9jEwznq+N//wXEdDOP1XWw24HN92vMcxSK9Lwfx17YxoWyFSRNyip7+kG1kkkrB0cdgESU+4BqnquANdH+0K+d5NSJ8hjU5cS/f3dS8+gG+sAQYdVb/X+ywxYt/lIeluCgXaqPNN3G63iCTcT3/kzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784507731; c=relaxed/simple;
	bh=y0wj20kffbJxYlrXnEn6MpmTpXcVGYGSwXUXbOrAdWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/+jh5nMcqRX/Q02cm1DLuyQsldf62N8/jhi6djmfwgGRHt1CHMYF2/MNLzK9SMZqpbeOfbiFQUM2nzH6hf3gM+82FxjjYYgNyHuGId+C5/uk9S4iLwStR4cbWvq4RxRKzLGpUgQ6kFINv3fUGXCTS4/gPttkdICnkidbPIWKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilHYWtl+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4NopdWM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilHYWtl+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4NopdWM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsJHq1019488
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DIVZc9WvO6gmd5WHUSG87kQYuWoUg3eVXKy2ZYS41/8=; b=ilHYWtl+1LQZlhRD
	wPICYoblj3VEBryZxIHjoahYqu8DFRsTevNHWTx18euFrO1O2cdVz38m4iz9W+ez
	xqff1bf6XX84VxZ+Mevdown5kEdpxeFprYtLqPJdvbBvYCHp1sUj/Y0Ygv7/aCFG
	ZoBJgdg1RezAt1Q03+sGVU7xb4uW8vr3TVeSifkrBtwaGoZdC4Y8PjOamwAaJyR2
	ZLqtmgMPZJWDuQ+PDuglVxxQBUkkaEw5t8/rX5N7C+pNodSWzf6cWUBXfLn8M9Gv
	4ybpVSc1PXMgfMmYrVCkZlCSDbX2z7xii060KcyuwfW60HSQ/uM248xAp0S4dALg
	4gPV3w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d93rst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:35:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cea6a46766so145128905ad.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784507729; x=1785112529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIVZc9WvO6gmd5WHUSG87kQYuWoUg3eVXKy2ZYS41/8=;
        b=i4NopdWM0E3344EHdRkYy1g2mLzmkuYlRrStX+YEiAB5sX+7N/odUIsj7RjpStTBbF
         vRksbARQkDGugSfNU3bhxll7a8vuV1R0+vAy/eDlPec7gydgfxj+VrIbBjmgJxbrk6IS
         MIIKoV3cwVZbjoUzpe6VWXD25+OOrckECuAwSuc8WOL+8taRJwIiL27mLgqkAo5PhVcP
         DDYlavolLprF3lI8jAzslBC4KyCUrfMQZfOCXFNE5NheJZg5L1qgYDTgMBoQZKezJdtE
         9K+H8OG1K9HZZ3L3bMaNJKH3SfHGj2iOc5fnIm3xz1bgYQXhtLa3juNyLXjGgSVX41ie
         JcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784507729; x=1785112529;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIVZc9WvO6gmd5WHUSG87kQYuWoUg3eVXKy2ZYS41/8=;
        b=UgUus+mFNggZtELvKLkGHLw6P8J4b/ldKZNhb64FDQMjKXuUnEKA9fH5pk1AlwCZlo
         3yoJQqAI4Txfy2AAmZHsBnyBn9nF7i1LLzeLqvcmyQRee/unHmQ6JOiYQ912HrIrkPim
         wkENP0zec3K2eRJjv50rieGx0bqZqlc6UuCjhU4sh9PyOrYAj1ivAAAl7t+wQ9JyTlU+
         1Vtx4f2yYYKhSFf5+2QHtcsd3QMxcGNLtJ3lBlce1sn/9S93AHA5MMyyTwH5w+Yq2uGD
         1YmDll875JimYPP9+lYv8GlzQFtPhZoMMgA+Q3xgoj7Z89PQPVbFgfJIy2HISywSkQg2
         yV4A==
X-Forwarded-Encrypted: i=1; AHgh+RqP5AdUrx/d5y7Grs7uNOXIKhvYKdvwaPtK+qCeVJyxYFlX3ZLGR00XuVN9Dr3dENRWaZ5GMp0LoSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4ZHh/zSF8fitOf8qXUuKQFz8vxs/cJ60HCeqlRLbkaN6G5In
	sAvfBfmPZyjrcNdmLTn0wqpR+/KBGO712eMQsBs7wrpNWXurRS6ALT23a6iuL3sPaq4+pUvph5g
	IwrK9+XQVwnUardMein+Uc9P4j6+XnT39jYeF8nYqGb7yOt4hSD3F8Mx2vedN4tc=
X-Gm-Gg: AfdE7cm3gNXNTSoB3lXYxPs9zT9Df2IBKPOIWlDbv7ZCyOe9XWZmdcPVzNgELMX4AVp
	03WqaO/x6bkn/5LqEgbDQPpqAmXgrLWC2+S3JeYxY5F8HqeK34fLYE76qw6TfLj3JhrPMBNzebw
	QQ/mxSuNiUotoWmxz39DeVYz79F0GnhxDweXrF05Gqxtl3E98wLaTwgTMmo/5bYGhEFlVt09a2w
	OmD2vs/Qjn9RjLyr9iazB+tek/OdQbUa18plW38To5Q8Ow3eCR095Xn8L0+tyxszXAlWZ+hV76e
	NIVBfIaiKjIa4m9xUal0JsQcH9UrGyCGnPEiBi7TfioEmWmP11R5m+jZI5fI58of+7Tcq5x/j6y
	XH8NYbkHYSvlRIfV7
X-Received: by 2002:a17:903:1210:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2cf34a0a6c0mr124569975ad.25.1784507728677;
        Sun, 19 Jul 2026 17:35:28 -0700 (PDT)
X-Received: by 2002:a17:903:1210:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2cf34a0a6c0mr124569705ad.25.1784507728257;
        Sun, 19 Jul 2026 17:35:28 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da071sm47034915ad.47.2026.07.19.17.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 17:35:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 01:35:21 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
        Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
        Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ti-ads112c14: add support for I2C CRC8
Message-ID: <20260720013521.73c50ad3@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-2-fe6e1c971288@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
	<20260714-iio-adc-ti-ads112c14-buffered-read-v1-2-fe6e1c971288@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5d6d51 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=IpJZQVW2AAAA:8 a=sghIrtzBG9ruuu9LPSwA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: R9ueHcxKtosy5BbGB9SdCFMgtvhukga1
X-Proofpoint-ORIG-GUID: R9ueHcxKtosy5BbGB9SdCFMgtvhukga1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwMyBTYWx0ZWRfX6OZz+7PNK7Ku
 a0rP/WNz0TM+f8Uq9CZMb+z0W5IIUkQVni3AR3usCjQHRGbSgKSC1tmwWHXwDd2KWOZn8dOwwrS
 5m4Bif/GSlNRbIgojJkqxahXP0LX4OTzyRAp9weHqu650X+GmtzbeCUxqRpP/sRVtmjkxDkaAyE
 VmoQI3PDCWuQuiQPeBc6fZOEZOdceA4oBcaDuqkfFn6Y1g5QyTht9XbOgAgHCL+Pf0XKtLUxOLm
 pzYkMpDrmORjagOWJ5HtFBqnlUB+3QM3nNi9hQwk7ESOEquZJ2NuFLsVrOZa+CoGWibTCXKJOzW
 r8D75NZe8MK8Cqiw2GgdH7+73vfxuTXGIm40ytrWWRvyEisk5+7M2VXBcI5nIX0WW8mQ0RslmQg
 +HjshKw/1vJX9zs003gm2oM3mHospCVosj9/y/ZgUG11Yq3esyvynkY/n3y5CqZQ003ylgvPw/1
 0h/R9qXYySw8vcwPRHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwMyBTYWx0ZWRfX0+Stc572oDre
 AbBmCuvSqWQXb/yix30SKcCBulzuOcGQzXPJzeuHIr6cwuRoaFzGFfxl5WtSfd0qeCPZiy8rVC0
 bRH6MXBJI6RZl82JiQEQSsAC16dkOVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200003

On Tue, 14 Jul 2026 19:19:31 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
> data integrity of all I2C transactions with the device.
> 
> For now, it is always enabled, but it could be made optional in the
> future if needed (e.g. for higher-speed data acquisition).

A few bits of this need a rebase after the tweaks I made when
applying the earlier series.  Otherwise looks good to me.

Jonathan
