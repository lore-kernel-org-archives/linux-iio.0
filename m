Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943922;
	b=L4d1q2ps+50CtoxjxVbjdG9BsO29+298fw/blh9+CITBecrD56Zu6ODa0yygfQgq9SAi
	 ZFwd+VWGXcLBNyeXXCADeHr5Y8VHkBVBPh9L5C8kIaqLWhNkWHRcNqgtAo8hzVQAFKSA2
	 zFZsjHaTCfZm2hj4+8tNaRnQRnfjvJQWRTj3z/YXNZWEFtZQNxWz8CnfK+u1qVniWFcNJ
	 906DKS0DEF1mK0raTL/RcQJseD4+KYumdff54X/SwFTW2xwElMV/DGESTPZ7Lz9QwuN/t
	 M6duiTdG0OmabhEvyvEbjNWNIlHk+rmrqPQ6VNjEal65Tpz0IPooJpbb3UmpC3zuOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943922;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q2L8DXdCwld9OCOazUytyYg/1wnMDhs89QIOzCqPxzI=;
	b=dj7gk1vj9F8Cy0o2Z8GwXIl7o91zb5PglyTzwJwtHjg5jic88eQrKfIsk7S6KfVOJpUn
	 FU9iqtKJUQg1xc+G0JgKoNb8TWERpuxdfs47wEHwe5Fh+UHhUgV/ACeF0GHJRq5yTsc49
	 1bUhbJlsSC1TTgdVb2koyJIIYi+7vqe2l8uivmC1NApbBU6OprRkoQ8SezpinXoCIruis
	 dnvo69PrpbMF5nihE7rA5Tm9rsmUcwVFFcmsa9HTmzDFas2WdwumSD7upa6KtU/mwu4ER
	 LEmwIDciByeavHFf9dJDauvEPp8j1PuLKBw2JQ0ENpQ8N1ATSeLtzWs14PsX0eI3zZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92109606A89C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 19:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92109606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed08b07213so606405ad.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943922; x=1795548722;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q2L8DXdCwld9OCOazUytyYg/1wnMDhs89QIOzCqPxzI=;
        b=Ol+C3tOZqdmrrAXvVfjewNqGinUYv3Z0lMU/ncMEAI0eEhQgdThu70p7kcaATMpCK4
         nOYwNr75pLfU2wKZjQa9QqP8SV/NCypzvYjNxZtVB3SbBV7H/wh9gkpEbhRXwevwOksI
         PNN5EipVGxmv9kLf/rKFgsBWo232bmf3ZcDy+4sbC964xybDV1IxjwbGg08+H6j1fyBi
         GVBfLflsvQRdeJv6TIwmEBwy41Cv5teGaP7oDNhEaRxHLqLOaZBwit1N8Bl+Uq6m0dxU
         kHtiPi8nX+kOWi6vSdBq2zwTyUOXrupigfaNefhg1iXkIGVkSSVAwj5cVPNd792MUWcJ
         1emw==
X-Forwarded-Encrypted: i=1; AL+hErHMI9HpaLY7hvMw9HdBqrlq2PUM4PAlUtpxxei+SbjzgaP2Rh8TMePuFMTnaf6tj4iZ0ouwngSDhGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z89dEd9nkv1TKRYMoQfH7cHZXxlbLF4J1Ifkaji5+fJFMYg7tRD
	F8aM8kGxhBFAQ504D0wBGLwS3uvUJftII/CT6KQvZPh4z1WnrNuzHPPzbMtNL2mt
X-Gm-Gg: AZFdTZdeVr3JAvuOUqEZjygHrmZPDQ6HaAua5yqzQl3dqpPk4mXnRA9GqQTBYm6xBFh
	wu54gNBiflIVAVyUCfIrtNIbWGbv5GryPZB5EZhhE3AzJXN+nldaYFrXkDQ78F/h0f8dYTHWmeg
	dUJH9yB+FoRUGeTEP9c6VpKt4qYA+miAHoF6hvmDYrB4fIKcktwwoeXkEanC5myHLTuE1enp2au
	VnryDejY7WCQRCY44O9H3tUkD+zhh9nR1DaIIrf5oDFo3+Ki/1/jMKdcW5ADfJkghzCff+AN/qe
	+QmaDy213+3SX3k9kKagVDGyENU7DoBHdBqGis6A1d6JqzNsWuqM6CaxejNBAJTVfZMkyn4JBPE
	/L0KpeWJD4R+5IgOTvu1431TtWmkgt4AukUq0w3aUaBmHK4Z1p7eJKE7AeiJMzX5aR0VAIbQl/O
	DzB5PInUFA7I4FbPr98Tg0kKwfDs/Eaewoe73n+1ZItHbGg15JvE26xZfKurGrEg1i/Jo9vjovM
	qDz7hYPsQCIe1q0Rwe7s9pGlz+oO8brcdJ3evF85GDeSDQbH5wReW+5pC6WMm8Pn3tyLNwljSSl
	Fi/qOrO0J53qYeXUx0P7BrnSbr6A42eq93GYEV2U68cti+tAhZZDSbj619sxLftA+zKKsiH4q0i
	3+9nJHyHkZnWJK2oHgR+bzd627hO5tEE3JZ8OCvIz
X-Received: by 2002:a17:902:f78c:b0:2e9:4e83:1969 with SMTP id d9443c01a7336-2eff751a4d8mr2390335ad.34.1794943921833;
        Tue, 17 Nov 2026 11:32:01 -0800 (PST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6192086sm1930765ad.38.2026.11.17.11.32.00
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 11:32:00 -0800 (PST)
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so405314c88.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:32:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFLYJXVEqU+/gmancW8LOaQ464vL5AE8D+oHo7eFh+fbytkHXzqjbtq/XZ7TjS3J2nac1d66NZPsFU=@vger.kernel.org
X-Received: by 2002:a05:7300:c382:b0:35d:4185:5395 with SMTP id
 5a478bee46e88-38280c3453amr432872eec.16.1794943919489; Tue, 17 Nov 2026
 11:31:59 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev> <avwP2P1zTgFteODM@ashevche-desk.local>
In-Reply-To: <avwP2P1zTgFteODM@ashevche-desk.local>
From: Joseph Telaak <joseph@telaak.dev>
Date: Tue, 17 Nov 2026 14:31:48 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4zHV-wCszetvFnVNA=v5O_rhY1YAeMNhS8r3nWC5wJCw@mail.gmail.com>
X-Gm-Features: Aa3M54rCns0V1-iSP2as8kRCd3gnBbNDEFw_nlMpPdbVKkD4iVYzP69Wrp7Z5RM
Message-ID: <CAPY4CJ4zHV-wCszetvFnVNA=v5O_rhY1YAeMNhS8r3nWC5wJCw@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: potentiometer: mcp4018: Add Analog Devices AD5246
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026, Andy Shevchenko wrote:
> Make it shorter and more generic, in this way you spread the same text to the
> top comment in the file
> ...
> and to MODULE_DESCRIPTION().

Will do in v2, with your wording.

> And here make it list that is scalable to expand

Will do.

> Keep it sorted.

Will do, for the DEVID comment, the enum and the cfg table.

> Why signed? Can the HW return something negative?

No, I'll make it unsigned int in v2.

> Strictly speaking this patch can be split to two:
> - adding 'div' member and providing it for the existing chips
> - adding new chip support

Will split it in v2.
