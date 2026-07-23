Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB5372EE9
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848056; cv=none; b=p2AY90jdH+w12xm/Xu5QI3b72fqapKlbkvTGnqUHYOfqmJFgo97XIA/Xa0UZtq7Jbco2xVkK1wnLElMW9uq5sBBF45zEE4VQI8PZLk7i6GiNizJ3iuxVGA1JrlXKNojXVOfyBDbav7PnyEv9+7DDcLGhKjbIkrEQ+tUmhNvYKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848056; c=relaxed/simple;
	bh=W3WAWfwjKm76x5cqeEv1mZOIhGORoHeLMYfdV0IahkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0EL0ttA83ZEB+cee4Gp/0mjSc5F99YWCl4aIntinqtmcXsSmQIZCGqhoEEJTvN89NVcCL21PIhLtKyn/JBJHsfkTZd/mFjVW0LY4PRFRiEAMlUyCuF07p9G3eZhZcnaQjYSeEZO0Xmd2IE6N3IKZkGw6vE8vHYq3PoAcMR/w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKiGqtDv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdRWNh3X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKiGqtDv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdRWNh3X"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLehed949329
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 23:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F6JlrUHM8mWHgshlpDOWVeAhgGevmf7PFwXz3+xRVRU=; b=kKiGqtDvGGgIboQZ
	MoVtMg10Y7Lf8ehuVRwX4UWROBvZVse3QW//NjtRcF+RLxcXF2oTLt85k1D9zMXM
	wUxa1XtuMIs9BDmojQH1/si4plCQGDI/ERhkvNGYNV4atOgI9OPvGwBun9yD5FwQ
	wkpfRnB4dGNUx76CtvSYBTz8GzHDdemAgSww7fZ/E+ZCdIU2yQE7ulU8+iNGqCZJ
	tmdrcbL8Kyoo8RcNYgyOJaRnE+owQTp3Kr3Lpu0JGgCxI0ep4LpbkLiwWWXGuQQf
	4FfbrPlP669ZiXrqeOliV74XFpJO+NvUyF9aDLq+8ypmsD+QH3CFAJSIipPlH5fe
	oV+FZw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0kuws3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 23:07:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc6dd43737so25723545ad.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784848053; x=1785452853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F6JlrUHM8mWHgshlpDOWVeAhgGevmf7PFwXz3+xRVRU=;
        b=YdRWNh3XhkZoi2aBXC7cKFaOhWpATvCEEEBnjv2jf705lZ0z6CfqybDkHLmhtQ/AVv
         OVx7Sh+zuW5FyhuKLPZkG2mUYzgRv3zHmU/HeGhN/jvEMXZxXjMuS9OCCb3CeSvZVCnL
         K4Hfn56cEFWdwsNmmJwQhn16NLWDZKCHUvKxTJS6+pdePH/QyvpHRN3dDWr+KFh8FWmT
         9xmGVRAZkL3J0gglk8118LAxfE4XBuIZ29t1aTGbgHz8c4LA4WmPxh5fL7qS4O5O6YNj
         kwi2K4vbxsJpQiKTvgVKRIRvaWMIb9Xs/uLeF2zOxdr1ABPVHsaAx4V+GW3uKJ4Un90E
         T8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784848053; x=1785452853;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6JlrUHM8mWHgshlpDOWVeAhgGevmf7PFwXz3+xRVRU=;
        b=gNkH44P67vurldlF5anZGN9sTDSf9ufPF/H/iB0nOw6nZqATeOf62348LFtKhTVmOq
         vmuxqr867jRngoe5JBZMQtvaSYpe0NlNZ51ZqwiGL6l3G5YPMRNrYdSrKQgzsJxKUiW+
         QPP7+Yf8wwY1FjuzOhfwdnknkaAwHVANSXpBLUKp3ZPT/bZPJ7M+4NTKaFIhscTTJwAt
         5/denXs2hJ1Jc4c9RqUQhZ1K7sT8gb0ac1NGEAoYDaXffS6yYLYF1TMRbKuoowrOW7R6
         6g/wk0SXomWpcYdn/enWWO5mNAfZFE7s5Vxf609G6aekM+pLXkOywYgaGn89U7dBCwhZ
         rSFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8vZ4HOE38hB0x8Lu6dUwl6T2fkgWeToT45DJbS+HlNeS0zUFX133drPxLoLfWFqNaa3Z0bRSRZLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1s7oPKOkMYLmQ0IUPMqYLdNwyIIerhklCTMY6w+MZnGEffQx
	48DfeXehAsMjAh4yqjkdWgnzZw3oOD7BgVBxNKfU3oRc/ojNX+NybHQln+waymElxS6vuHAQyo3
	zqIUwrIcUIywdSeSq+nGIyRTxe5+lljtZL6qtqhi4dW9us3rAMzm2uWu4+A1G50w=
X-Gm-Gg: AR+sD12RhxSI/KD8EpCyvsxiARRuFogU5kOm1Wr8zHuOVGLKI8FokhLRYnGsZOW1rcK
	SpWvK/Q55OqdeJC+4DuVEEuz9UuBskTdaOR8fUKChZSCYmIloMcnjWCnME0wluxKYFlBZ6M37Sh
	ywCD4yQSDQYDpIkTHkaV+xCcONio6e8Caf3C1etDaTdw6U1xGdD8OzSWb0hVV44DEkUG0tzRWFx
	FZXVVFgJyCcyKt+VeD8Rc5Zv7eV17BXHGc0IsbnjwO1e/j18Rm31ry1MJnE8k6ubhQXQmP8JUpL
	MCErWzR7hllGNNKUaLJIlpfgWZ2OZ9oWrbqu8h3d2hP8IwPhQTPwWqD1V4dZJEqwXEwfMKXhSlC
	5+mxZwzZziTQ2bO8E
X-Received: by 2002:a17:903:22cc:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2cfa74e3bb7mr62120015ad.23.1784848053046;
        Thu, 23 Jul 2026 16:07:33 -0700 (PDT)
X-Received: by 2002:a17:903:22cc:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2cfa74e3bb7mr62119695ad.23.1784848052651;
        Thu, 23 Jul 2026 16:07:32 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3be1ddsm41205935ad.84.2026.07.23.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:07:32 -0700 (PDT)
Date: Fri, 24 Jul 2026 00:07:26 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
        Michael Auchter
 <michael.auchter@ni.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/4] iio: dac: ad5686: extend device support with new
 parts
Message-ID: <20260724000726.6810f531@jic23-huawei>
In-Reply-To: <yt72xnzniqqiutxrmfbk474m6jelzfpzdc767emqiwomgxg3ez@mivshbbogi5o>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
	<20260719-ad5686-extend-dev-support-v1-3-841ec75cf5d8@analog.com>
	<20260719224351.1af8aef9@jic23-huawei>
	<yt72xnzniqqiutxrmfbk474m6jelzfpzdc767emqiwomgxg3ez@mivshbbogi5o>
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
X-Proofpoint-ORIG-GUID: 1rHvQgLtrGFl3QFos01ww-RAmNAIT_vn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIyNCBTYWx0ZWRfX073ggVcCD/cw
 mFXC7U3gVXbbyILkJqbief2CkoYcz034oVrAeEw57qwhwpNYOihPS9q2PqsoEZZjZxgj6zyGXCc
 WzcSddbK4LcpcfNmZMx9ksAym0ELucI=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a629eb5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=LT-n39R2GKJzoR_0PBwA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 1rHvQgLtrGFl3QFos01ww-RAmNAIT_vn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIyNCBTYWx0ZWRfX1kb059/ibOpl
 amkCgGjvtgdMYnsCqDaksr1kpqTlEDGTUDuCx1P+J1KStkZrHEgOW1wr99uV1s4gJPaOnGG0y9W
 1XmKdb+TxvlEk2IowOBjcEo0ljCR7g2f1ax98CMOevE4Lraejds659yBXhdV7knKoVnG/eAFIy3
 PKVhQNEfgGeazcJcyigWNzj5CvGC5s2t5qM5PTRWBYUtj8eQhEFsr0zxzTzfNWHFwYfcJisd60x
 R8+PlJjDY1x8+32psRtimznngNOXlDXWpP3+PG3cctA9QTFo40d6PK2cidKS0nIHQo+Sx6SPGAt
 7OUhRoU6RSGQeINsb4ias5+2ZChBm42tfTtYNe2sbdMY8t0IWSim/NA5srzxv9yGwjr2lfe4w7s
 O7RMlbB9FGehePxH4Y6keXF1B6hthFYLap4O5PfJUPfpvNsR4Lm2WniaAAd8fQ1BYiW4luokkbn
 hqLYzuFCqtvLId+YQpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230224

On Mon, 20 Jul 2026 12:16:29 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 19/07/26 22:43, Jonathan Cameron wrote:
> > On Sun, 19 Jul 2026 10:51:59 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add support for AD5313R, AD5317R, AD5674, AD5679, AD5687, AD5687R, AD5689,
> > > AD5689R to the AD5686 SPI driver. Also adding support for AD5316R, AD5675,
> > > AD5697R to the AD5696 I2C driver. AD5673R and AD5677R were missing from
> > > the of_match table.  
> > 
> > Given I'm asking for a v2 anyway, please break out the missing of_match
> > table entries as a precursor.  
> 
> checkpatch complains adding stuff to of_match table without having the entry in
> the dt-binding. I suppose the desired order for the changes would be:

With a good reason it is fine to ignore checkpatch. 

The sequence you have is indeed the ideal patch break up.

> 
> clean ups:
> 
> - ad5696 dt-binding: adding support for the 'missing' entries.
> - ad5696-i2c: add missing of_match entries
> - Adjust reformat device list in file-comment headers and Kconfig
> 
> extend dev support:
> 
> - ad5686 dt-binding changes (new devices)
> - ad5696 dt-binding changes (new devices)
> - create new chip info's and populated device tables
> - Add new devices to Kconfig option description
> 
> Does it sound reasonable?
> 

