Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903945;
	b=h6eH9M3nFoswgdgZrpTSz4JoeEIWMIC9PcfGABh1xgUH/vp15I3r4UE3LTp2gZf/4l5j
	 fXGyjkJJ8O9qs8De4rVpkInbRUSG9skMvgSGVOWADSUR5O5nypE8n/ZiMLmV2el9R4wmq
	 qX7Kh36oJ9W8WN2QpC/6KUrWxXgI8F5dIa9u6KArNgvk7E3CW/heIxdxnd1TVGluXIdAR
	 HcETI8rcZ8zaHw46YjhjfEIE0wwQyBmuNlz/PsVYiat3nly7uPeH5qQ8iXrcrtubtr043
	 Bkz3tqdq2iEHhmkNyRxarQWlz2JryuJYAUHpXclHYSr0Ch9vHaOBc8t2GwnjOrwvybA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903945;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=XGcxmoYfjlX92YHiOef8ZcG7B1FJUqi9YCrtia++R2Q=;
	b=n/B/x2w14vE1k/VRBWTIOi+3/RHYwdwfP4zMV92C8BE8DHgvkBj4PeUeeh8uzM/mmpVd
	 WcV3QpasXT7J90k7DsPTIKyusPB+gxVEKLYjP5STeZtBQ/dtz8oM0KXv/+ttGkBsnj/Ag
	 jTfO/pH5+sjQiqKgO28ygdXJsKdAv2A9y7vhjS3dAbhg79GWvWxwFPB3MP3VOcEXbisqV
	 UuZ69MKulxs0f6Hg4vqr4NX9tnMG63jvVOcUpeS6DH09rDhZG86day6Bypj2MswGK5xqR
	 fi+4570EYdH3nEKW8nxkKZJVz7SOEoilu1kbhiklJ0iPa6VoCWgbvS9aaDyEY1ICvBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1C606A88B
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E1C606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b1535be329so3204043a91.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903945; x=1795508745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XGcxmoYfjlX92YHiOef8ZcG7B1FJUqi9YCrtia++R2Q=;
        b=nUAmHaPGKg9hzrtE/XF6Q9OBL+tqNeV+rGjzlHszrRP9GMe2/QO4L2wVIfNHzn8O0q
         WEI/kWAqFKMidk4mEt3x6lBU6gdiS3NnLD8BczxdXJte0ZTsYe7dRI0maU8K38J4Jl9O
         Stv/TLTVklRUGFKbc4jU9ENOvU8B59FakYF8aVAjMNrLMb+DFOee9cRYSd5eAQFx/+Hc
         TqucbhLmnqC0v6VjdMDh6Q9ZlLW3YKCAAnOaZKQr4Ad67IbqafkUksYGJ3N2v/DIETmx
         Iv9kCZlow4Nz4wrRFChv0Lf3QQ4coQEH+Zik3cyLRPxlD5bvZyz5rvpLJCcUeQ4MCwcm
         sD0w==
X-Forwarded-Encrypted: i=1; AL+hErGL24vqQ+L6vtleKI5m0/U5UHqOQynFMuXaDjnMucQYIZ4rY+CuV+ldSc/mNXBs2gOK9+7GSKqQktI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mRZXMgTAJQuwgtgJZPD4zKtcVNyS6QBkJEKin6KAXzMh5MyS7
	qk44OWApGvjkCTTuivKKfKHWgtzHvXT+Xd1XTPxGGoO24OZn4HBVEk4AOBRxUpQS
X-Gm-Gg: AZFdTZdQTnDLD83G2ohdQir7Fxj4mEWP27RL5TLy11UJgHW6WTQKsBZ9nxcenttF+ca
	kKmopNwotIDdR4p6o4exJ7onYwFLLMOW0MdZDhqYA031FiFTyR1P1Y+6Y7cRnjgGNh1GaupyE/C
	UiBsCzaj+dRxUylUDskB9684N9DXRU6E7uvhuAr+m7QLhohEu48hvMX0Ljvrw+iC2uNy5DQ9mQB
	Eendc47f6caqwQglNcuFoEJZ35LkzevGCgm3BOPCgUv1nHWsOcOkepQ94DrQRvyeypCgzR8FFBA
	pSPjqm4LYcWZVW74rliwMnUnyf1XEPavwUWcnLErwbKyyEvtLrs1a1I0lz19UWBbiNDlXT0XO9l
	MViGJ+6AF7PGgdA3FhCtpRB2xLGYoA/4Oqv8FFs3CXtArOlTbZHHz2VVhObInHUMZ9Joiy12eyJ
	qjmuyesZ9ou99efEXN1nZpCVrB5YzfpiE6iQS0vPtQ31XqEZ+0L5rz5voAY9cYB/EPEgNcxIqcH
	hwd9O64Zou4oeflcKAfyPL5/4uhZlJy9VY1jhfM7nu5ykTTWpz6OGfYOlyL7SNA3pX3/8hHuM2G
	bAAfv/vyR121gsZwxR8qehp6ZsOrmFxkc3zNHv/f/1crXfBKrmfsNYYqKmBEISQzrN5AJl9xYKY
	Dwdk7GZhHxnit2UQjzOYf/eglYuAD00njoNWj8nCSHZAd
X-Received: by 2002:a17:90a:5d0e:b0:3b3:ab75:c94f with SMTP id 98e67ed59e1d1-3b3ab75cb5fmr1344207a91.31.1794903944637;
        Tue, 17 Nov 2026 00:25:44 -0800 (PST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com. [74.125.82.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac292c53sm2964358a91.7.2026.11.17.00.25.44
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 00:25:44 -0800 (PST)
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380b40312e2so3045737eec.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:25:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGDkijCvbxZdDML4/CI13/J9tN1snwQUkmhtwPWmGqMO0FGJLWANMENx6T2gp7mGkGjJgHLBtrMqe0=@vger.kernel.org
X-Received: by 2002:a05:693c:811a:b0:36e:9763:9268 with SMTP id
 5a478bee46e88-3796695b721mr12921261eec.26.1794903943562; Tue, 17 Nov 2026
 00:25:43 -0800 (PST)
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
 <20261116-iio-ad5246-v1-4-ef6b7c06d4b0@telaak.dev> <avwNWJnsOQaZSWi8@ashevche-desk.local>
In-Reply-To: <avwNWJnsOQaZSWi8@ashevche-desk.local>
From: Joseph Telaak <joseph@telaak.dev>
Date: Tue, 17 Nov 2026 03:25:32 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ6jC4S6ktOBGZ5us4FgJEep7QeFOP3zs6NgZyV=kTJzrw@mail.gmail.com>
X-Gm-Features: Aa3M54pGquVNkJTL3e8HLCz0b2WyudTbs-YMALBBjS-DCyuiUkBpa6nnBIohZys
Message-ID: <CAPY4CJ6jC4S6ktOBGZ5us4FgJEep7QeFOP3zs6NgZyV=kTJzrw@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: potentiometer: mcp4018: Turn on the vdd supply
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 03:20, Andy Shevchenko wrote:
> + dev_printk.h // dev_err*()

Will add in v2.
