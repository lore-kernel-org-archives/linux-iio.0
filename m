Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5058E2DD
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070470; cv=none; b=Vn3tpz/sLx6GUr8yobNjQFiR+TuhB/oX6PK0D+Kvq9MX7JoLEFUJiBymdh07cdiWa0Vh/jeswuam9P5OCYFByWaLANlkCvuMFlXxdR1WJm4h4bpAUSGTr3hfHKMA6ni54PvokZ1T3sRohOM2HgPZ9D4FN1G8PlheX+Ha9oV9q0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070470; c=relaxed/simple;
	bh=+EaRlpTj1R6GDSMIQEBaTdrHPWAUOhK4v0G+2f0OA10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np+bZXwYNKJEHw6BF3A99qIOpcdz7RxYGYm2YdTCvsvfvniWJdjzYpK9OJo1Z/0HkT7cxBbdgOzsXydgObwfGDpKQY4/n8yTncEcpcTsNnPPS+iiffkIv3jRtf0z+3Qt1aUt+tr1lGwHPJ01/hg7lf/LJdXpJiNtf8U4iixk2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWgljTv6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWgljTv6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso2680195e9.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070464; x=1789675264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EaRlpTj1R6GDSMIQEBaTdrHPWAUOhK4v0G+2f0OA10=;
        b=PWgljTv6VfENaNCYWj03P4Qvaq3SqBjmpSflDweCRAjsvCt62k0de3RM1RuRQoYyq5
         8mSx8IEUKs2Vw9diNcX/WRQVaIQNVogwaOecUKxwUFG/qeXhVq/zwARixnVSTUhMY68N
         Dg3i/oBJbtJn4vkz199P/sbXEXRYa3a1mQKm2BFc9CeVzDMcZ9AOxCbs5gewAYmnGolZ
         tEO7wrRJSslobfzchs79h/7hYYaRlOtL60z5YjJsG12qPTHie2ySODF6Ihq6kEymFn1t
         HtsafG/+JUap1haxNfWJyX+IS3+W3/1UxbELCVCRW9P/VQSf9GLOMHwAGRxsqeBzxx1m
         01MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070464; x=1789675264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EaRlpTj1R6GDSMIQEBaTdrHPWAUOhK4v0G+2f0OA10=;
        b=rbx9FDl/ZTLEcUNhS9c79ghbgTxVLJJVLfM4OcnOI/76L4Z6sZytFaXcaOn/I7Rpfy
         ZvZp1XNMFyOb719SFl4miXNzUrxzQ/CXbkH9I8PiJJtvxkTBIR/TXFfuHtjlnacIWCVT
         jAZCdsvRAnygTbxNhuzuLcHcNtvkvf8SG2deP1xaJJvtHaaKuFk4y8zTiy8OyOqGakEg
         zJV4SMAsRA41RVNu53nT+B3boqQVhh9A/6myVBYpbD9Da47epKmZF/Asyk0eL51+d9G7
         xlslKPz17MZHU0/XtZfIQ8vrBoPqx9DPVcsfHmfzC5N0ePS7kNoBYK9Txd3V/2XAarR4
         COWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxB/WoGsHfIxydIqGV3Fec9EFA8ZE1oIpUjRmoG9LEf8pAt2r86Vmp0JhnVZhg58mlKZxpG2dHxrOY=@vger.kernel.org
X-Gm-Message-State: AFuF++nfDAo3/k36Qa4+sI+6YMQUveM7BN7wEM9FFwdv4jeqsR8gkMM7
	dPWRaUaVx3eELUdhHYZAE22FnE1GSsZqhvO2jxKucsuxsSpVTStRNG75
X-Gm-Gg: AYBFou2+jQCSXhs0jHL6uIxKAJaOQ4ltzUrFeHnsTFjD/KYOf9jSlpKs0W4h2lzCqR3
	t7k06Xwhtd2fCpbbbHeMMh0aBL4E95Y745Pvg1XZySh+nlxO9jCxT4pcu+Q4VBexrdqVC+D0SmJ
	TM9AmR70LprV83dZ1dAiMCrkoV6A+HoQJ5ihFp9d29Wsc3A0+j3S/2CWoyfJ9XIMCHxQPH/1DY+
	6fTk+sSBv6K/zyTOsTPdUAGVYBW0fK/pUByWNh4FgF4VhaTcskfOpeMWp4B1cidzPjtLZMh4JkY
	IRho2K3lxjU6ZbROCcwOX6m8b46lwu9ZzvZ+8s9O8GuEOIAGmhgErXyQSUoxYnz2ReeSdj1tsqg
	VRNZEqKUAFkyqE1rlsduubS0mifwUox3BUxcrduz2M0f0BChpnYpUaLe226+a4OtKd4vrEBHlBu
	i6MFDbJn3omS1w+y64HHKZ8L9dg+Db1T5I9333ROYhDKmU6/UqKR2zR7ScSnyCpYU1+3PRVstMa
	AZLlZlQoT4WRMiCMejfz/yd9kNSmqVvcn7J7b47Qw/G1kU=
X-Received: by 2002:a05:600c:3484:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49e619d1eb8mr6258665e9.27.1789070463744;
        Thu, 10 Sep 2026 13:01:03 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60a8a89esm17674895e9.1.2026.09.10.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:01:03 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads1015: Add support for label
Date: Thu, 10 Sep 2026 23:00:59 +0300
Message-ID: <20260910200059.5975-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aqFoE_GKp_hd26eF@ashevche-desk.local>
References: <aqFoE_GKp_hd26eF@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 5:07 PM, Andy Shevchenko wrote:=0D
>On Tue, Sep 08, 2026 at 10:20:36PM +0300, Flaviu Nistor wrote:=0D
>> Add support for label sysfs attribute similar to other ADC devices. This=
 is=0D
>> particularly useful because the label can match the schematic signal nam=
e,=0D
>> identifying channel voltages easier if label is defined via device tree.=
=0D
>=0D
>Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>=0D
>=0D
Thanks,=0D
Flaviu=0D
>--=0D
>With Best Regards,=0D
>Andy Shevchenko=
