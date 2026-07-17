Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F51A0728
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248068; cv=none; b=KgqikkAN4ZejnTWotf5K6swylZt66cbvINtHM7ifphhc5TYQZj7CUnAqk78QJTfW+71Wd5Mv6U1y97L8u/8AGe1gdt3LhYbd1co0AIzCYJEzT3VZUW8iM6GIvl3VB/Dcogw4z8ER/Q9COEn0/RhUOD36BQp6ViwAHqMf7VhbVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248068; c=relaxed/simple;
	bh=WuxboMC8gwuYa9IvYfTHmmVyytT8FQoSrk7u1Q1bNM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHutuZHSYNTi7x7YM+BovJb979iCrq5UUdgGc1OPT+MO6WE4iJQO3Xh+Scm7PLNedDUMnrc6KNtvtGdyXVCaH6em3VxfmhoEbsq1V/3JLkS3j3r7il8fhYM7BdNHNmEH9PIRNMoeh3bmmg0EXO5HmWGKjGM/zh/UYmqhZivucwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=amcTjttH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J5N12laW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="amcTjttH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J5N12laW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNJS4J120565
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 00:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CXMtlO1SDpulkCJC4RwfiN8jyZ4jMbi7pNzjkUsjMVw=; b=amcTjttHrWtguKC5
	n++lHJEs5cWDSbrwXvydXhhqunjR7ll8/C0DW8kN9C+hSMohgftQUZLG6krSoG2q
	AJaR4wmVw3hM2uJI7ByZYhtiKDm5bQUMjaJkqH3cS21J95WK6WmCRyd9ExGRW6L7
	v7ZZ4Y/fdnneG7aPBMTFocabwVSjpLBtqbNeehXf9C7Ew8yX5ev2PXS1PkPWDS6Q
	m7KgVk3VEuAjSIw9fmtKPQdCtx4+GpYw35ECCXAvPyYfvFWwOVQBeOn7Gybpgoe4
	ogzAXGzGIzJzBd9v90ay8F8xZt6aghIG/HTOoddLcJ9sN4W7yNDRoO+6EhZV4WzU
	JZvh+g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10bxw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 00:27:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso17071535a12.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784248065; x=1784852865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CXMtlO1SDpulkCJC4RwfiN8jyZ4jMbi7pNzjkUsjMVw=;
        b=J5N12laWJ4tlObv15JycFnYxrI3ljqf+5xWw8JwbTnjpAoQtQgS0KBhIIo7uKjALmQ
         wXLDr6jGpwQqOXMOJwTaOBecd4c8VkkEuQANqm2tVM54oBJExXPLfK2x1pVLK6tTG5DX
         KCTfhpdZh09tnt9fi9+7OtgX0a060KUWjIpGU6B4UzS0f03LoouEun3NhcQ/G8BX/pLk
         MWgLoZiMRf1KCBNhzEZFVPRqXUuPtZmGobPMEP/sph0YjpqQjNmAiM0G3Fa35qZiE2V2
         Eg4csrNvrLniC5E4Ixj3Pu8jOK3el3iL5dbbTPX/kmDZCQ4AcDMOFqbhIDwqRWpC50KT
         hsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784248065; x=1784852865;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXMtlO1SDpulkCJC4RwfiN8jyZ4jMbi7pNzjkUsjMVw=;
        b=mx0PZjccXz0ajdJ5egWTuFamKLRYqJ/qnDSYHAZkXAiHjwHsMgtPKGzvBNwbBbjJEc
         L/1lMQmOGaeP7k3WzdqYJHhKuBw2SdyPevcHHGLRbGH1X6nEO0UenV6NiMaCk8ZYVkEg
         rT4FQLgsVjMJRC2ZgMq5wdduX/DuOScNz/qrt0EKWiliDm+OqwxjRS5Q5+8g2qfFMcft
         2lFrEc0nPrrLZbXbyFfsVBjXz+yWlnWtHThVzpuqgIa1vYxdAQMvu2uvLsgsPnYQMRQF
         aN53b2haACeUd22lAX5872veGmkdFKM0Ia7Tf6Eqiymq8NzMKlh2YrXtkBISDW7MeOI6
         mw/w==
X-Forwarded-Encrypted: i=1; AHgh+RrKkgkTsSUTsOy2NOulgHOWE1j+OjRCToSnVGutaM0bHDStlwl18D7yWK0m3HfBpsrw5CjB2xuilOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMIYV8X87faP7syRW2Tp1KHqICr7Ep2aFLGPmt3MCgnH9eNBi
	uRwNYmx2HfpoC2c8CyySLroZ9MWJxt2HHYcEWukPEE3fLx33tvsK3KXH3gJ00suBH4rpvdxRAbL
	H2DtMj8BS32rHug6jmGudCxDCXHOOLwTy8j/TVnRqyZRx3RggtqcGYG2bIn3NcX4=
X-Gm-Gg: AfdE7cn9C3TY18b2p8fdQKtKgaClIkJ5ijsBatl6e3T7xQyls17APPlvaqzbK6BEzwn
	Ep2QMN7T5OUzrRasa9EOVKpyElIv4uqOrtDc9adZ9/MzX0YjP8xH45FnaNDLboNrWy6NEvvNb11
	TB16cG6ALhF2MF7CZxTt38RrvpSlpeOBUjNUkOb7S81AReUsulDpQ8LGQF0HPXat8qcqz1ZxJTI
	Fw7pzQMZF0eNwvr7N4e5dJPdxNormyJh7THCEl8llRXNHtPTV/Ji3Q1ZB9OLvsTctdEbBbv+32o
	FEVobnJ8K+5klClpOUcm9y0hfBZR7X1nKl2bQ/SA8J3LEwKXv+NteqRVIsTG3QaSZRwI0IPHYT2
	Isj5e8inLCJEQexTrEEkvke6Rlg==
X-Received: by 2002:a05:6a21:a8b:b0:3c0:9c18:d5a3 with SMTP id adf61e73a8af0-3c3ad97361bmr219831637.64.1784248064698;
        Thu, 16 Jul 2026 17:27:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8b:b0:3c0:9c18:d5a3 with SMTP id adf61e73a8af0-3c3ad97361bmr219804637.64.1784248064246;
        Thu, 16 Jul 2026 17:27:44 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm523718eec.29.2026.07.16.17.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 17:27:44 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:27:40 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <20260716172740.00002b37@oss.qualcomm.com>
In-Reply-To: <alcpb-7GVSfk6jFB@ashevche-desk.local>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
	<20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
	<20260712020928.2c8d1667@jic23-huawei>
	<egyms7ulkxsgu4pvfkoruelec3sf6ca4bndcuqkvxljrdluqwu@edlqne7oy3xs>
	<20260714180812.000070c4@oss.qualcomm.com>
	<alcpb-7GVSfk6jFB@ashevche-desk.local>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LCqZOMFeZUHRFaZw7Xn4s0ACACNAFk0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMiBTYWx0ZWRfXxh++vHSnk0Jd
 oeX1Afm46YOtTk1Hfl/UegDgianHbEzs57UYOagiVicEtR7sEBBcGj5vpNPne0or3mW16Huy24C
 nUocukPhSk7PEmXYgnkrOppirKavW6LVhrhuMVtIuhrRhTcQdnBGgXuUZxQHJVZa7ss8ppmU3fL
 ViZMR+oy+RlpVvAXZSXV3AyZxFkLLGa/k2NSScFdVxYURrBffaBFIiSq7CLsNjeGSXOmBUkW28Y
 I/P2uwvvgu12vb0BO4vf6IKEwif5B2GiGvxuokTQstaICcPPZA+a+dnZvc9FApzRcIaEMxN59GY
 eF9kcs3Uk1E2Dxb6u7icC4v1pAteaylKbWmZw1PpENEdwh0QF+/YmRunXecDfL48ufTyIjxdcO+
 ZdJQfWmMuEB5eTNeMWMNMYjW/Ag1kX+8UQdyvJCzM46j/t/fRi86nKsaHqr1E27JPzDsKLGOefp
 qNoFrKVFh3P7T1P9qgQ==
X-Proofpoint-GUID: LCqZOMFeZUHRFaZw7Xn4s0ACACNAFk0f
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a597701 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=xcsdVRPUYcZtn2NnLoAA:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMiBTYWx0ZWRfX1CO0vrhMHuM0
 2OX9F+0bRS1vvbmw6zPN7MN7xgwq0AzoUzmPQfNCkXvWnDKFZj9tlyC3caOQ9S+6fiXmrKyGlII
 +BUBk386WxNo58pbOyIhQe7rc4QdKeo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170002

On Wed, 15 Jul 2026 09:32:15 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 14, 2026 at 06:08:12PM -0700, Jonathan Cameron wrote:
> > On Mon, 13 Jul 2026 10:52:56 +0100
> > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:  
> > > On 12/07/26 02:09, Jonathan Cameron wrote:  
> > > > On Tue, 07 Jul 2026 15:04:28 +0100
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:  
> 
> ...
> 
> > > > > Because __iio_chan_prefix_emit() is static, the test translation unit
> > > > > is pulled into industrialio-core.c.    
> 
> KUnit also has static/non-static automation via a macro (defined in the
> kunit/visibility.h) and I see that's used in the below example.
> 
> > > > Isn't there some magic route cases like this that makes it non static
> > > > only when self tests are enabled? 
> > > > Claude tells me to look at include/kunit/visibility.h    
> > > 
> > > There is, Although I think that using
> > > 
> > > 	#if IS_ENABLED(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST)
> > > 		#include "test/iio-test-channel-prefix.c"
> > > 	#endif
> > > 
> > > was more straight forward, less invasive and easier to change than..  
> 
> Maybe, but thanks to this thread, I fixed other modules that use their own
> approach to use the standard KUnit infra for this (as below).
> 
> > > 	/* In "drivers/iio/industrialio-core.c" */
> > > 
> > > 	#include <kunit/visibility.h>
> > > 	...
> > > 	VISIBLE_IF_KUNIT ssize_t __iio_chan_prefix_emit(...)
> > > 	{
> > > 	...
> > > 	}
> > > 	EXPORT_SYMBOL_IF_KUNIT(__iio_chan_prefix_emit);
> > > 
> > > 	/* In "iio_core.h" */
> > > 
> > > 	#if IS_ENABLED(CONFIG_KUNIT)
> > > 		ssize_t __iio_chan_prefix_emit(...);
> > > 	#endif
> > > 
> > > 	/* In "drivers/iio/test/iio-test-channel-prefix.c" */
> > > 
> > > 	#include <kunit/visibility.h>
> > > 	#include <iio_core.h>
> > > 	...
> > > 	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> > > 	...
> > > 	// Use __iio_chan_prefix_emit() in tests  
> > 
> > I'd rather this wasn't built into the core module.  So prefer you jump
> > though those hoops.  
> 
> Hmm... The above (while being verbose) is the standard way of how we export
> symbols for KUnit tests. Do you have a better alternative that everyone can
> use? (Not only IIO subsystem.)

Ah. I put that comment in an unhelpful place. I meant the include above not this bit.
Absolutely fine with the exports being there.

Jonathan

> 

