Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971B2BD5A8
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011975; cv=none; b=UEmnVVjqYxXhwj35QU/h68QN+dA8KKxyIyB3wByUOLvcFnho7s5yETEY7JlLuX1X5BvUqbfi7N0P4OHoSFx6dF0XyEdWtVt0Y35WAq0GDolPjb/T/QMKZfdrHIXdxSy1IwkqqM8TO4LxMaYvfLKNxDo55QTwj5L7OT1kdnqwA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011975; c=relaxed/simple;
	bh=YmHJEuBe3u96/M5TfzcpQLzrd/hwj8LqW44BvHTehMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB2MXnuxYu1h3P5Yr4TugRV2yCMU5STF/8bjYGwI4WEI6EQI2tNmP1Xv1/8DXOaaoYarUubm/B7Vrls1nhafk7qlom4RP/YYrX0XU1+NEdbfkG0qOg9LJrV9TfKb9W98qhe5Z+CyiuGGU5vKeHK2vPTIPnayep+ONn1GHVkGA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho17A5xw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho17A5xw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so27773555e9.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784011972; x=1784616772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0hxd2lhkwloh6ADyskPxgB6Nys7+6GpYXhDY1KSinr8=;
        b=Ho17A5xwBerL7RKQqe34ch6HvUHAemWCq6p+iIhOZGh7r8fNG4CGOgFR3HAVz/zgxW
         YG7Bb4wr8QRaLMy86WadsgH3+ZzAtFcvdzTTlyWXlESjsra52A8ows1/vuJvE3xWEace
         innNH9FOpSEWwVr83PL9T8F88UbeBXfhYGfW3LreeGKcgNX4j1czCg8snjOTqkMYjujv
         6+b0dzEBG+ahqrWBywWbA3O1O1LevcdHR6nAlYAUrbS5vWsyzCtyppfZhyfN+6A5XCpm
         nep51l5QAv4UPwAcZ8aVMyCrViQKarm5VTgfdTYvQZpFsJNdmK8yzGtVK5r9gAVk1+FY
         NL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011972; x=1784616772;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0hxd2lhkwloh6ADyskPxgB6Nys7+6GpYXhDY1KSinr8=;
        b=XnK65MAhyBNbZQr+hHSWwdKaLU3Vg9WJYL1a6dBcNmH3ORQYXhUlP2tSnTmZlb7HEn
         f95lENgRWAaZcCXbs4DhrBjIoZLTfJa+sMvi12V7MANuTxu6smTJp+AYVm0qeE5cJg0L
         ZKQbAx3/k8oJShrFl4JtRyJrRru0rAkgzJ9Ox+EbpDyTcXFaUwM1fcNWkOSrYQl8FEAp
         zYWd1d5gHxk/WOAY5XKGF3cVlWwVs/IrdydN8/9gFNacLGYHhh35NI9sEz0bMEa76cHs
         XV7roExr5ZzTygX62iX9hUgwE+xsBr7BYTtobyeByzPZ9qs1oc5pEfrqw+PXBrUn6t2w
         3fPg==
X-Forwarded-Encrypted: i=1; AHgh+RpPZOcCrkIYAvGYgexCcXaN9X4JiSg7xVJqroDDiWTkXCqSxHy1apCDSz40C7+BsuBiNnZMSjB7ZHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3yutK4j2f97ZECOlL04MN9F9w3TLZXAHgr+YXk8empWYcYFu
	LdxhgLh3IUOvw0v9UQcOA/s9aLXD34okSJ1EUi5Knaz+ik67QxZa0RCr
X-Gm-Gg: AfdE7ckK5nukNukVwUI1V7aJqUGrGMoovNS+bfoSaITYOTHWlWLQyxo063mCRdxscRF
	iN0Vnv4oy26I0LsyXwNA7KXO+bzm7sAmmhKbxiJkXvvv6a9KcL3ngB3f16oXceiC+cH0ZFLbEPn
	8/APTQ/OKngI1j/I6/4b0JxvopVIo/x7RBIzIrjWJ8HObCONJCOVquw5XM+x7umxLrwQUrs9dEQ
	tMVLeA2LxVAaoW2aWIqauK3WnJWb0CMUbXwEakAtEFlbMXGsgTCa/UYEvJx2gFk6SUBCw4tTagU
	2B47mGmywVONjsLrhGu9ruZMTmIWVMtcDwkRAC3cNOrQnSy7ZjZSN7P9h10SW1h7f0ph0lqTaCX
	7YVjTYBZQ+JU/wkSCQcS4wfKd2Yv5qOnuWZV/JPpkwSn2yoTiOdsx3uiCHHPyA7Q/8KG8gITAy+
	M+daUXHgHTYC7X7xJtieEObWOGV55KaQjw9+EIBNI+DxtxwlbTCX3fogz3Tsc19ukuJ5h/W9L/Z
	pUKdKIdXvFUZ2T+LQq1IbrLKjQVQyAtqW+PFu/tJN30Jjc1vxk38UHU4lVFEVQ8YLomEu/qus6n
	Ltitu9eqtxzRYUeg8tgDTVVrBELnoexeENOVa7Bxh7OBjjK+3tun3sN2QCoi4J0/XCaiv58kSMD
	mzJLNfqTpicS7+Ci+DERq0r4=
X-Received: by 2002:a05:600c:4c12:b0:493:ae5d:8c40 with SMTP id 5b1f17b1804b1-495389c6b18mr7119025e9.27.1784011971725;
        Mon, 13 Jul 2026 23:52:51 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634debesm6185587f8f.8.2026.07.13.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 23:52:51 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:52:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: OrangeBlack0765@outlook.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2583: migrate to sysfs_emit() and
 sysfs_emit_at()
Message-ID: <20260714085250.00006e9b@gmail.com>
In-Reply-To: <OS3PR01MB82448EEC71E6AD3236F39E3FAFFA2@OS3PR01MB8244.jpnprd01.prod.outlook.com>
References: <OS3PR01MB82448EEC71E6AD3236F39E3FAFFA2@OS3PR01MB8244.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 01:08:33 +0800
OrangeBlack0765@outlook.com wrote:

> From: Chengrui Liu <OrangeBlack0765@outlook.com>
> 
> Replace sprintf() with sysfs_emit() for single-value sysfs show
> functions, and use sysfs_emit_at() for lux_table_show() which
> concatenates multiple values. This ensures buffer safety and
> follows the modern kernel sysfs API.
> 
> Signed-off-by: Chengrui Liu <OrangeBlack0765@outlook.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
