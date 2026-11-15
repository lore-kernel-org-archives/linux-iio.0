Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707020;
	b=Wrlys4lGbGAPIjRncW8UNvGjcUIQFKtgmkXz7PWJBAiUPLInLY/2qzAJRKqzWcQdedcX
	 ibuSrDrUGn/nr7U8+Eyh+91g4AyNkfBabMBqqEU35P62vURqcKsII4/Fsvp2K1o90D8wJ
	 jQF/qekXpsJZ2tJ3JCCGV1pkn9WxQZSy2COFY4Eg6XP91aqYFPib/RYvtlTy1So58tmVR
	 amKVJrL8VmxN1dhY+BMx9Htmmw6mJVTBMsEbsA01W1aOP5LOeg/V3DHUqG4IJnBlv5ElI
	 ayBXeR61ZuCKRBkImcRg/3IPLtQa7a4WW3JiaqqBrcMgfKQxWhgwQ2s7KCiFM16ib4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hoZlbj0wt0HdAew9G0yycAAEwE1YWzSFVGwCqXFJujM=;
	b=nKS70+2IQaWZoYH7bPhOizzYMMtQUILSWXmvPhyg7P2tm4vuR84c+m9IHVFB01DZf97n
	 8I9NWi4RvNnVZ6gJVNEDwddD9VSfCODtGbXGqZ4BqCpYZ1QZmSwuP7f9sT3aRUqiedXpD
	 S/KjzKIGttHlAJI7eHOo5mwfDkOjlJlwz1EtjEdeX2azXcuE1vEE1HFbxBGaWZnhu9aHp
	 LoSQ21yZnxu8Sdi1kPAp66oCK8GjuHzTj2PfMOXiYSuzPzqwtttEuMU7UJo7reL2Lygnh
	 GJzwOkkt+X+6p/Y2WeOqu2s7UqVsy77Zrgiac6FTnbulBpmaYYqwSPY5P/hnEPFmjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ut8JYdZv;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C64606A327
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C64606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ut8JYdZv
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3acec6677so3016549c88.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 17:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794707019; x=1795311819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoZlbj0wt0HdAew9G0yycAAEwE1YWzSFVGwCqXFJujM=;
        b=Ut8JYdZvzP/nP9e4URUURnTz+n548KKW2eO1J/xalV7MEVuGJPADViFg9lLcIGeO79
         zEr9/mINW8SPP2a2hfJysswou0imFVVvkkj9rCyTDcC14GR6MRPnSAhrPgHnLP0GsuyU
         UTYVG7P1adIX4ERViTJOrlngvCGjsspawdIWPNJccDR5enzjN9b+drie2lDjlVa65kuu
         PKmXvH4wQSB3YehRdEjDuelHTO8CutNg5zOIeRayCVx8X3vVMdB6oO5Qz2ESzNZNQiFz
         gkK5bVan4tkGNfWa7A7Cwe5cX7NcriEJGHTTM7wBALz5E+IQ0HhhTo37wQxE4xKFkVYd
         se5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794707019; x=1795311819;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoZlbj0wt0HdAew9G0yycAAEwE1YWzSFVGwCqXFJujM=;
        b=E76nhe4PSI6iK41WcgZM/LLcpO/W5+1XbnI3/TeiIzC0fDW27PgA4I1tkm1ekPoq8G
         cA5yWitlGMv+ExKYa/dosuWEzo1xLTQo6Pfq+ngTv4qL7uoX8rXgVv61ZOg1S85s7mJF
         3td8epUn1LP6+GPuOUgdX/qDwkTq86n1xp6S+ScFFHpeiQLbLrRE+77f26JkS90Om0gj
         7nVDOz6VcTqJrMleX7cVAMmS7SUw+Mm/ovYtTVI8KBTENzukeOj2e+5x/odLJig5si2C
         JtQJ08NJsktC4WdC7UTS7ZlWobaq5aFKKEHcIC84uLD4vk3NWHzz8gY2pgUcX9uu81dD
         5rAQ==
X-Forwarded-Encrypted: i=1; AL+hErHc3AHPtLlPTBbnoutY5n8qa3Ww5ZFBkxYjveYqXGxHLg7vVi+l0GE1c1EOiivuEOMnR9nmLGxno5Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e6Dd/HAXJDpPlPJRU1ym+LMLf5kNy8n89nMrDm1otjm1sNS+W
	Isd5rNhUA95BN4SLlz2XHe68T8PWp9hrJxx1ZGNWDOFrborRh+rz15zG
X-Gm-Gg: AYBFou2UZ1x3a69JWM5L8VnNT7Y2ZzmkOtxBiOd79FmepE1Mb82i8QW+vaoQ49gf3Nd
	zfobAwUcIFkwIC+M2eUWmHSaoWSvuL9sMK4kzmt1hcysDh5G34RAP0Jw5fjA0fZ2C4kbszvnUx/
	9pK0C9AkgNnkqI85Zixql6OFGYEUJiTvJqwojz3b63ykQe9qLsnO78BYJrqEi2lYly4yjiX0Nmn
	S6Rn0FBmmEwit/pNnxaPnzDtOCMVS7q3xL4OlrkVzmEHr0oht3Mo/unxaalcTixTqmtAtv4cU90
	udPx0d6B0UTllFGiZ/P3iPmpOc1+Q7Pp2RDNgk4JGgH38b9P8aq/doAvmN3GXvF834nBdFqnROF
	8+R/CBDlbXPvHFRFTMei8euw0OpNm7NIcpe/pNrpokAWzWDwwZAYq6Kfct3R3hcfEjsECCBC0Qy
	5cV2KxSizKej7e4KAKO1nZXrSVwuutGdDfmPC0vgTEXzkS9I40P0u9/Ne6wiBAMDujryKPfp6yr
	54T4mHnu3MeXI4JRhnhjQIY+oRx5JI0MkBd9dfNJkH6pZvVJEOPXnefSZPF6cL/3fRKJvuMjGmC
	g1xzw1IhN6cBDwXtoLMuQ/YKUe8CRaUYqIMW/UYUaTjDYAqSPlGdVJjGbrJQopugwfU7rtsn3rX
	WOa9tX4h3txjLUl+4rFV4SbLQ+fGnPuSd90tX3YKR95VId1S0xvf1FKLoT24mixuMiKe6qPIdEp
	yZIMC3JQ1MQNcU+M+fCXMTOuVNpcNDQ+a0AYECoP5FWA==
X-Received: by 2002:a05:7023:c006:b0:1b3:a87d:a6b6 with SMTP id a92af1059eb24-1b503163eaemr6040022c88.42.1794707019087;
        Sat, 14 Nov 2026 17:43:39 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm29990799c88.3.2026.11.14.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:43:38 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: sx9310/sx9360: reject out-of-range hardware gain values
Date: Sun, 15 Nov 2026 07:13:32 +0530
Message-ID: <20261115014333.120063-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avXeSbAEGhkMjMJa@ashevche-desk.local>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com> <avXeSbAEGhkMjMJa@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 05:42:01PM +0200, Andy Shevchenko wrote:
> Now it looks better.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks, Andy.

Jonathan, a related question while this thread has the right people
on it: the Semtech SX9xxx proximity drivers (sx9310, sx9324, sx9360,
sx9500 and sx_common) have no MAINTAINERS entry, so get_maintainer.pl
only finds the IIO maintainers and reviewers for them.

I've been working through bugs in these drivers for the last few weeks
and would like to keep doing that. Would you be OK with a patch that
adds a "SEMTECH SX9XXX PROXIMITY SENSOR DRIVERS" entry with me as R:,
or M: if you'd prefer the drivers to have a maintainer?
Gwendal, as the author of most of this code, you'd be very welcome on
the entry too, if you want to be listed.

I don't have the hardware, so anything that needs a real device would
still need someone who has one.

Thanks,
Arnav
