Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D852848AA
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783811663; cv=none; b=d9vhfFYD8FKuyKXXtWl4gKQswJzCVzj3PwzwT0be9KoBtv+fsb0VjQzXYNagbOwxlZU1tu1kcgyN+3xh2GQFzs6B21K5iSj9vJ1JNT9nhsfvw+G7l1YEg7xyiorlHjdrxU+NqrgWybNSBc/8mdhjmQXpvil68/wH4SupgH5pzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783811663; c=relaxed/simple;
	bh=EHGw54sKsJWQ1hQzRhATaYr2/DetzRiCOtT0KFSI9Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrp635Am7DoyICtLCJ25nKzYd4eBIdV4pme+theqfwo4c2XPa92PNzew/w0M9eX8yNb64lSr7te9hr2uy0WCQmpZSfJ2e9fdjRVqmTdOquPZje4C5j3/HWC245UMN+c1FObl/cifo2SWUisigW4SfofLIvrbFBVsEgOoL1S9fGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTo46Dne; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJPEufeY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTo46Dne";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJPEufeY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BKwslB707232
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 23:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tkOX7/TAel/cmrpxcy/qt8cPl9Sf+yVa1N0EotZKyl0=; b=LTo46Dnekt61/Y5a
	o3leuBGV7NmtsgXfibCf1/BflZE76bnzxYWpWAj2nCjKYJ+hQOABxTgfCHM7XkOj
	DQ/DajAm0MqOLe7gXKW7N+u6wNlL8nwT2oUdTTXpBdH6QZs6X1cnRNh0k+i7ZbQ7
	sgLh/snGQgOJMh3MSDBJxcc7mSR0iFrwDoXsOt6kZddECL/LT8zDgKZHDJb+W4Su
	9dVDKwLiLirvrFgaY8RL/xPHfYwGlH6OsCdXZSL7+/SubbPUHgXIexJgs8A0/QCH
	+07g81stQI8b2GmBHtIVWtPk7Oj0Qz9cSUUCAeM+B3AhwzokIrcdG8e08juvPNOQ
	ysahlQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr1qgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 23:14:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c8018f11fbso31275745ad.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783811661; x=1784416461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tkOX7/TAel/cmrpxcy/qt8cPl9Sf+yVa1N0EotZKyl0=;
        b=MJPEufeYRht/D0dn2yO9X9dn8kDuhtkIfRaAGt73sG/q3Oml8/0j7dB3iul2eoC5th
         OUAy/cUAb6Fnp8R5O9j4ZzJ671j5VTWIiihuDsFlxzT9k924acG49WCa1N7NXhRBbdTk
         FBrHLv2OEz8Afqtz39ifmMNAAQEmayaSWq/TmJPIEEkit2PlbaYSl2e6RB4HMtzvlGqV
         9BW6njNeH4JECCheIzcziuFrxcs9Ny5ttUyDfYvNf30FrchYywkc5sB+geiBVnF7RMCc
         R8GNf0TBwWkKDgn8ThnBYiO4MPHjRmAmFS2gakwMHyUIz/SoxW6xTvmB+lSoVqpkCMny
         dlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783811661; x=1784416461;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkOX7/TAel/cmrpxcy/qt8cPl9Sf+yVa1N0EotZKyl0=;
        b=TINQH7xa2Pgc6aIjDyGSn/J0xOh2aaTEKQtaVZcXb/5LTWjEQ+QX0FwVYepzaZH+ie
         wWunoXMaQafmF94XcF7XSqxSTOZJtzO6BoEGDbhhvjF2KptJ4WbD26o56cT209Y66tna
         YdPHJaBFG0cuJZxUSho6MOIyp9oTnJMTIQHxZ8Bw23ZKksC4GD9+PjI+SjFTp8ehCzNl
         NY+N939QGteLRtQEXN4+MtmqlUdHpFjRCA49bqPxZ0STF3PEvv9poxOy9R2urPbEmnUj
         jMocNkqfp13tZ2dxPTc4654LCCtgHNEG66AhV4mDgtU5+OE8pijMaLQce1dK9jTCSPxT
         DPfQ==
X-Forwarded-Encrypted: i=1; AHgh+RouM5/OSnJHEHsUxRozDdCqAg/bD1mMe+LjWFEpOyew559Jljjs3v4z2A02YuhbJdSNNPy5wx9dirQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0R5kSrNp3zWx5w5AAce1qgiFb+vFPjhSrpixzVwERvBLQkyK
	xQJ+EJ3fqeFsj9n5yoJ3DOHP6CcyMXWRuRZClWegC6fDbseUElBf4qfFTHqS+3UEbdwOKuFMISJ
	snUsu5xec4CFoZj0UnQWI9WdPctPq9no3/SIhB6DjPEUiWdV8Wc89EFt0czGOuuQ=
X-Gm-Gg: AfdE7cmUOI+K6QBr5LOqj+p5B6J1IAu/kl+V/F6tBqr6XiL/L0g3YeSERRND8eR8gvJ
	vt3pJfs8EINUCPhvM9/vU5fZda1A3Nzn7sJGVhi6W4jdVPxh5LyI3PZfBZhjI2n0y3Nj7eyfUmV
	/pOsXwyMDyv1qeopx6TF/wJrZVncuZhFetEfMebGbA8ZUbw3PJiMKphlTB5UJ4feazVgeDc9vq6
	zqqN/JzxOey2ziwN74vhSb94RCrFcA2id64qIXSwRt2mkrt4xczqiiPI/XIqcf4PIDam2w8pmWs
	IXyzWHlZyxx4Flxu3gHVxY0v3dmt5fdpFkCJd+GdCFww2VdIJuqjOYb6wOWJzfVrCcQI8ApUOq/
	n66rUirV27W/sKEUOqJnLT4OHQ9Q=
X-Received: by 2002:a17:902:fc85:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2ce9ec12126mr39887335ad.19.1783811660706;
        Sat, 11 Jul 2026 16:14:20 -0700 (PDT)
X-Received: by 2002:a17:902:fc85:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2ce9ec12126mr39887095ad.19.1783811660224;
        Sat, 11 Jul 2026 16:14:20 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb86bsm78488355ad.11.2026.07.11.16.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 16:14:19 -0700 (PDT)
Date: Sun, 12 Jul 2026 00:14:14 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Paul Geurts
 <paul.geurts@prodrive-technologies.com>,
        nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, tobias.sperling@softing.com
Subject: Re: [PATCH v4] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
Message-ID: <20260712001414.70a87eec@jic23-huawei>
In-Reply-To: <akwI7bzJUZasGbq-@ashevche-desk.local>
References: <20260706074803.13624-1-paul.geurts@prodrive-technologies.com>
	<867d2cb8-a1f3-49e9-a8a2-04e232f404ab@baylibre.com>
	<akwI7bzJUZasGbq-@ashevche-desk.local>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDIzNyBTYWx0ZWRfX/ahqtieX7kRN
 NVEaWXrGCcIjYrldjIZFKj9nM6zYWIwl26Enyn2VnON8wFb2Qu9a6U9UUSTBq9LWLCfY+GRAfRb
 U3Gc+FDLlk9yDP4TK1KLWlpnJRkbHu4=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a52ce4d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=GSyO0BWpQcPk6rojcgkA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 1QgJsIczBqTBJQoBmrmTcqJa_YRLzWpV
X-Proofpoint-ORIG-GUID: 1QgJsIczBqTBJQoBmrmTcqJa_YRLzWpV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDIzNyBTYWx0ZWRfX9BPZeWtdj4Hr
 2rs2Jh4M4GqLONCEDyMnFoFmQZR/kICJPCGEczBnsdxKUExk6O4l0gBL64pJkFNG8FjhIeEQFmZ
 Q7+IdM2+UZPsDmlSVFhe3mFezFX6jyEflJt0MXPqwQW2VbkKC91gZnnfXiKHV1oXWvnN6A2aqhi
 1Ki963o9k2FRukD1JpCB7qwvIJindIacVcgbTexcJgpx5ZcD1ck7sPtTuUmZuHychu+iFXtAgeh
 uWua7Q3IZTCqiftvVx1Don+Faw0i7MOn6HoCLE780ldStFCqxqST/SRIqoK0qM9mRmiHCddrMEM
 KQ4iIQgNhcQTudKmHGjZiBWQcII5eObIQNqSZqytGciXIs7cAK19234pYrGP34BUluA7IApvUyV
 Ys4cSLiIS5r+2KTGsD7ftvm9yS8x+wLG1KouAE228+lGyWn/QS9Yf2YVliKdmZKA6we6ZuLmJSn
 w2CMJObcn2OKmxe53UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110237

On Mon, 6 Jul 2026 22:58:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 06, 2026 at 11:30:59AM -0500, David Lechner wrote:
> > On 7/6/26 2:48 AM, Paul Geurts wrote:  
> 
> ...
> 
> > IIO style is to have /* on separate line for multi-line comments.
> >   
> > > +	/* Reading the statistics registers reinitializes them. This is unfortunate
> > > +	 * but necessary to prevent data races
> > > +	 */  
> 
> Also multiline comments should follow English grammar and punctuation, in
> particular the sentences should have a period at the end.
> 

Tweaked all the stuff mentioned and a few other bits in commit message.
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

