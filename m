Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745023;
	b=tlYq1Lbv/UrhQOx3pAiyQ3Z4CgiBi5c8SNOlRTywLXaylsAqDe7hZeD6KHwebXjSLdQt
	 fw4bkbg2Mg/UJ/kExwS9y5gxsBKH/tmb5LJXfZejuJpzPOVg28n0RkcWRpjI71c7kHjNR
	 htVfCuKxqL/DsKK9lq8hl7wOaGsq72JrZjFHdUSISB41dVSx7fYIoWnFnAkD7npsIp1T3
	 ULeFzxAfUja3mS+s2EOUAeSNVsP1w/dW+A/GPAAzNSQLApGb+BU0J25DLVm2NQOxU1BSb
	 fWZxwzT+QQBbKOVVJJBciyfzrc1KJNgxrTHU5DCnOZDmVmIxZcaisbib6Xo9bgZmxOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hgKtrYuVdHjTuyfAuNXo3fwBH4AA45vWJgvlpCPw6wI=;
	b=sv22wkNy3plyWiqKsTvE+m9r6/RVN78ppT0OkFDggRcqZ9tL+3JmmttybVC+FAnnk8nS
	 BtUpkwExBlN/WXBIvIAhwL5ADN7OLAfYBymYm8gVRMULcDDJY0dUSd+Bom+btd377PsXx
	 EEpcuC36LmawrYqV55ZIXDQUM3msBA5emSb4S5b5ZRd4VtzJMvFGBT4hfCw10D7f/b1bl
	 LBjq9x8KnX6ZPt7Jngml0bQTB1xgdM8dhRCptZazLuILiYTNlgdM2U3+FzuswH2K3ARM1
	 ntlsz5FiCdroKaPTH+pUqOv2Ug3Jg3OPUcOrjYukx35EDATBlw3QygdpoYrD1UXo4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2dGWrOV;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D1606A32C
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 22:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783D1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2dGWrOV
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so21879e87.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745022; x=1794349822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgKtrYuVdHjTuyfAuNXo3fwBH4AA45vWJgvlpCPw6wI=;
        b=W2dGWrOVUGv1ANZf3ckgVdemX0Kw/WCv73oR6CJXNdEtxjuzVsutJVdicfjM0W2jRL
         QC4487aiFQx3l74qyzXTrPeDLLGq7SaOiWOj3xwGHv3LmIoqSgYhmGQJ2gbHNFu/Keuk
         /5LgiOLVMpPMRkfTYbH6B+28sAZN5brxhXlF0CkjWJeGV3hVYb26mlLnYu7Za2l8nfP/
         4ZE9zuQE6N6THXzH4WfeXJxp6ukBJigrIFu0U+0vzTqSFhVEeQX4JNwiEmGmdtaTdY0H
         NNoUXUeaAwT81EKnTYjMLkzXWhM4W7dQ3hNOeI9r5lynQS7phtKGgD/wUMTtbUqZnXEQ
         yj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745022; x=1794349822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgKtrYuVdHjTuyfAuNXo3fwBH4AA45vWJgvlpCPw6wI=;
        b=eMe4ph8+bfrA66pnmvtWnROqx79nzCe6GiuamJ7gsOshNFZgJKYiOfge0FkD28+tuU
         ZgBPdyQIHOI5kSxeD7rHKv1UcdT1/UdaLX9oLoeyOfHzBOIOYoGM8F3hKgDyt+bcYj2U
         vyf106kzh9XkDVN9CfOBeGEX7KMzlodXHmTqGBPNO+MkdJF7SOaC+Dkh/znEFRONwuES
         N/HGB7N/84eIkeogrwrbpDJZsFBDN3u0+LhzUAgBSxwLrjK58N7zzpuaXdXk0hSG9cjs
         z8uhN+FMWmfQLZEenuwFd4l7vkScCSTnaN7qojfMp082+xi/j7Y+N4XVWx/q3v56t0D4
         eA5A==
X-Forwarded-Encrypted: i=1; AKwUvBwzUheyDOqHBQoKVqQluPK3P8kWLyCk27yiMzQ4Il/GH7QmXSssynNyzior4pJEym13cr5kMP0iVbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lUa7qGvjHLCHJJBh/wZCZGnqDWQJd8u1iWkqKikl2Qze3gBn4
	grqZQbAvAZsEwh1jntlV7oRjb0IGwSG7f+9pBB4p2X7L8Oft26g0xPo/
X-Gm-Gg: AYBFou3cSaBD22quyb1t/gN9T7+45PQ0xtuDkl/uVjK6Gi6RKowQye9YAkwFaXIQQ57
	pWdlcbWjFcsB2DKcreH+ZM9fzsycsTJo3VeBpJiH4JDsWCLzS1wolWMzGj1YAH5uILR11Bm0QIb
	Xm1S+Y3OxdSuaWOsHqaDI0U7fcZDjp8enaRAN/ZzmvO64YHUx1wg/LRWZ+6NOdYgKw3AJS6d4kH
	s4PuWAkQpKigG4xKdj/C2vgq8qn5Y0mTwIYK1hkKMvzswfy+lbxtjPafQEOiT6qP01e9Fqe8sZ6
	bFCTzo8rzdWztiDLVm5P0EoEPslNEKeUq5zt5gmJPzMY1mCSB6LYqE05QZ2OKRMab96eIjM8nPH
	HCUQysrFLqA6LTV1mpr2EKSJs7SLf6rAJHHv2dknh5chL2+i0OACR3LT7pRUdj1UQcdFMPvcfNd
	Cx3KuAtahfuXy0XHTO/1G9Qk+Dd6FXDH70cTHn4D8s/Z6AvyhSZG1988S+68aKb3scXZ35ydvlf
	SGOz63BYcptx5W430cH6YV96T0Jx0iYGh422MhMGF2HwfF4n3HEcBWaFjfppvCYCP3Lyqblwxbx
	RtsaZR4JRui7SDOcw8RtU+5FK0c6sA18L4HUTGIXcMswBPyS95sQrflSSiF2Fc4ORKTKDJ7lT/7
	4OXiaLf5izFevx2m/Su2YCxpDt3fhphCGPqsLPg==
X-Received: by 2002:a05:6512:3f13:b0:5be:54c7:75f5 with SMTP id 2adb3069b0e04-5bfd95651a2mr5290197e87.18.1793745021435;
        Tue, 03 Nov 2026 14:30:21 -0800 (PST)
Received: from yantra.. (nekmmqti8d1bm4i6lqd-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:6004:6869:8249:b585])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38cf919sm113677e87.63.2026.11.03.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:30:20 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: paulius.zaleckas@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: pressure: dps310: fix input checks and resets
Date: Wed,  4 Nov 2026 00:30:08 +0200
Message-ID: <20261103223008.12675-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029220635.18816-1-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paulius,

Jonathan is holding this series for your Tested-by. Could you give it a
run on the ZTS8032 when you have time?

Rupesh
