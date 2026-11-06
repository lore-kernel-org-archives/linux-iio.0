Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793984081;
	b=BiaupR0+if5pqfxgYbmpTEpBqrE+RjtMu8/PdLcsUSWBIlM1yMu9q6KKf6GGYuEAy1NM
	 H2QIDgTjlXeamu+OSR5hB+N9WFwpqjUGunzsYYs1bkkmaVN/Rgu1iL5T8UzhV5hTsLeil
	 waDbj1mfI0Umt/dSVEuhksDeyKG55PD0XY/M0+/NTG5vC3OA/CWFPAOn01M8BZnd67koP
	 hnvPR+GNzXjjSUak0+KYf+lIuiqWNJbYGd96YDAmWZ5IGXeB1ivLCV8naL9zQqCFO0fFZ
	 6XlzvWx8dShdqV/EDv1NgqnxVz44dWEr03H+Gvc3qsQPaSH+ba60M9o7P+5TQmL/bzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6i4oUXdP885wW7dG5qidGLk2DhrD6UR6ZQWDrphycws=;
	b=IO9KhehOr377Ey8vhzNDkhodOCh6CAUvXTgEgTZNN+bCSrNqWJdIveQlY/Xpi/B+Vg9N
	 XwL1INTXukcrjNOrpt33lBt00Zj/3uTrZu2qQinQ+5+w9go++v6kg/zpbAZzHCrW9q0VN
	 e1/Nu8WeZtF6vHUIp4ZNGi+KdBpMXdO2WiZMju5e9wYNmA7sspylQgzPjas02d8npDFtz
	 SaJxw0QArA+IWNHdKsZps02BJsOAEjSsP3H5SZXt61lTgiYgxffCn4d08q+hM795JGthO
	 Ew4ERzEVsW3HlwH83BamxzLAotpkDz6ScmtvM0TywU/noRcr9UYuwTyNS4kKeGcRWlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SmHlFGNm;
	arc=fail smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E849606A32F
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E849606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SmHlFGNm
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so8030215e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 08:54:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793984080; cv=none;
        d=google.com; s=arc-20260327;
        b=F1aBCgJm0F8M+kGBLhkvhOaM7Ef3wPSoLGtjDmwvv/J4KimY/aZ12wTI473mqgaviO
         ZLDDfk0HinQw+gV3escyu0sa8x88y8WH7QaY4s29zAjg6inCG7AxJHzS+oxQrL5oVZzH
         2EYn5m/RTUWwh5OmEsY0qMivVJ9yD22NkfktVii66obhrVbCiCZLHE7Xj8n4wO87TMCF
         eW8uG2JL6Gwbb7Q/awNXG7BE8wP0Y+5A8mtnQ+hTtKw4CpZ3CW6VOIXThF4LI08yBxMg
         hFO/BWuhv+0+/DW+1uHQuYgNm+xlSd4Ni6P5EKnhPrfb2+p3c+4+bo1u/eStC36zZL7o
         ituQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6i4oUXdP885wW7dG5qidGLk2DhrD6UR6ZQWDrphycws=;
        fh=BivX6e653ANGsYRaStpPfFGF7ztemLZWwcHYuhO6GCU=;
        b=TuShL/YewXrOTEcnWTjZ29np5Zgykq64hogjhC4ERXJrUVRYzzZnPH8EmpC3lLsBEs
         r+8CACm6aJSQkw5zOie+KIDiz2eBzWPlnGds/OphdzOtXd4jhYptMqH4gSJDQyK/9L51
         /EjokrqsDsslhveJYTzK17AVw+BL75Dj5n90cd6VwuilxuHquDCNnf6bOiV5gc1MSgXT
         KOKs+uwH5PCaFhQgyhHi6kjtjYN/RFo/DYRsEOsQ/mhzubyy4OqtOmtQm9DBMxIkfRuH
         po1UsKiVL1+VGwilkxD8D4FFYVUN2auslNvEYTKtYJHVqeRUyaAyXXwQfDvxpMBWYwTL
         2mFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793984080; x=1794588880; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6i4oUXdP885wW7dG5qidGLk2DhrD6UR6ZQWDrphycws=;
        b=SmHlFGNmIjwnF2DR6HyMJZLS9Z0G4KCuS9VIwzgtntwh7SHVYAa+aqmdgqQM58kmzU
         U818gJGJXeEpPlLRbtB5p1E/s3HFYuv03oRspD1QMAEN8ewS0/FFrny6z5U4ajmdEc4U
         ZPXH1FKEhomQbYsIQQ0CnfpJtcQiO+OSn3QZ+ItFPl+ChWgbC0bajWNWVJs8c2/0idaM
         1nFml4+5UEmW0s42p68V40UgsuXOvyokl20xeCfrwrVgYWYTk0+r9sAQmYN2g0Tda1T8
         sLzAzGvF7qDcmwU7dWt2qdZcaINHneZIzv23xaS00rwhp9i6zEMAjUwG2YYoFA6pxrqS
         ntmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984080; x=1794588880;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6i4oUXdP885wW7dG5qidGLk2DhrD6UR6ZQWDrphycws=;
        b=2La+p0hx8JClmZr/TpRehTzwaiPAxSd2tVpPwc5ipUYUBfEELtxGTU6yrjhOYbKOtm
         WplLQqYRTd0OQvw9AhqpQMNlXLdggcvcuOXGmlXe3+kqodp/K5QZVLIPobnDyM0sAEqP
         7IRwt5KzVdo6nLXqCP5Qv7CmM3Cq05KwPaAQyG/TX/rbVKwXvbFgjNP/r9ZTJR9GBRpo
         BmmEEfcx5wLIffo73mElRUGj+uOOvl7iPZBmtQ4VSNBEMymO/WE9S711TR/Ff+YgM/LU
         A3v7QX85viA8acE3sr3g7McP1tnU5Zwh7bQ4JOj/Y8v+PshGDIw5Tg7U9Ik7YgKedKxW
         jILg==
X-Forwarded-Encrypted: i=1; AKwUvBzdIGpjbQqnABO3jqecODvgOitTC2QPTWiQ4wQ7jrC3bVMVsmUnOQnDVw4wLMcvCmQt9A3yQ7Guyho=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tVp/t+yaK6LIqntbaH1BpB8rCH4UahnxqeOWZ670Ze3OO0Lzs
	YOy59XFpV/OVLOQrjs0zWqKfbXnabP2GYLBPAJSXRDO7tyl8l4Iie+rHbT9gIb8AO/BHoWCion5
	vuSDCvhIB5tWP4+6EreRKV8CSfJUEFYw=
X-Gm-Gg: AYBFou3c8hmRDy06v2438gSpSjaekAMw8NXAzmYTcvulFsC+Pmyl1SOvPzwZMTbaliX
	2tQFgTpmphpUqcKbT53Iir0dWKMiWYd+i1MhOQJdfoZpfap1HOxSWmed00AFovn7T5ss23iGsKF
	FvDGqZD34wRu4fmMH14rQM/dpLNmfJCFRORFX6oAmPTjSOfebWa5UGPWYD1fF1ij0fcHH0Ury8i
	fluJ1gOblNWDddWTFw+i90VY/iTIBDGGMrspntF30GREBzoQJh77JnpeHkO5mjUZGpSJjPmf/EN
	kB8OjbPLu8Cc38gur2Me6xLtnyKU9NthsLojbiPldmGDjuolV2I3GLszuoqG5S2TzPaeo58mpcf
	LjqOnOg2D52QNpAVemo4pr0J57JI/0Ud6DN59e3onOb6fVAlrKh09pj9N03UKMd8I8n8vcCHOov
	di5gkA/foaM1fy88s=
X-Received: by 2002:a05:600c:19d4:b0:4b4:49d7:bc25 with SMTP id
 5b1f17b1804b1-4b6dfd97b92mr54279315e9.21.1793984079658; Fri, 06 Nov 2026
 08:54:39 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tle493d-v1-0-3246e91e6394@gmail.com> <20261105-tle493d-v1-2-3246e91e6394@gmail.com>
 <20261106030419.23ca9b26@jic23-hlaptop> <CAFkCdFyi0GD9aWMUZfx=QrZMg1ezjUDCdRr+LTsD0JMMT1DeiA@mail.gmail.com>
In-Reply-To: <CAFkCdFyi0GD9aWMUZfx=QrZMg1ezjUDCdRr+LTsD0JMMT1DeiA@mail.gmail.com>
From: Viral Patel <viral8854@gmail.com>
Date: Fri, 6 Nov 2026 22:24:28 +0530
X-Gm-Features: AclHuK-KYnr_aQ0yTXhRBn11b3ztP800Zk1SFF5R7aNF7AVjePHX5gpKZEe8GRQ
Message-ID: <CAFkCdFztjTpXnm00C-TQuW0_GC0Mbm91gAa-JF-fuincgfAZVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 22:14:42 +0530, Viral Patel viral8854@gmail.com wrote:

> The Pi 5 controller doesn't support Quick, so
> the reset was not exercised in my testing.

Correction: that's true of the mainline DesignWare driver, but the
Raspberry Pi kernel I tested on advertises I2C_FUNC_SMBUS_QUICK and
sends zero-length messages as Quick commands, so the reset sequence
was sent and worked in my testing.

Thanks,
Viral
