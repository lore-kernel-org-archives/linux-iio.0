Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F02F1FD7
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597062; cv=none; b=NYkd0OiV4YT5qKNSgvEu4BiLBwZvkJCJ1mYkHREw1nrAMWdajnAeZxzuQrTRC6N/GUnelXL/Eri+oU/cA/O0fFAHLGUQrA2yKNDpfMA+J9bf2yUKvDugnJfmKqVz1+Mm2nCO99nh/T/q1GM+aBocAVRZuWa7dFkuB6EbBmfSOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597062; c=relaxed/simple;
	bh=WP54E5Zozvp+1GAPNgjDcxymFAEsnkay7BW+MQRPQZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIG0N7MsCWnqHtTyCXjsejnWQMMfN92Oe7YATDsvh/LcvF9U5kOnuNG4u1RTA3wrBGeuen/MQyl1ezfQgq1mJEOadZuPIZeWRww0BsdjExYnwlj1Ptm0B7b6LnbixrWC5s8UKeLghzhU9LlYEtoIXUVQHiPNBBkeVp9APexWfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha5CU76R; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha5CU76R"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48049955f7fso57796965e9.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769597059; x=1770201859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WP54E5Zozvp+1GAPNgjDcxymFAEsnkay7BW+MQRPQZQ=;
        b=ha5CU76R9iZ8pR9i5SRorBW+YfRoQZJ+N+JYGk1jvvV+16SA7ty0qgPRJQmerqpHSi
         JDxzy1/xUjSgF4iWgWvujZmlSiL6QJ5l06VYv0U7bldTlqLZ4fr90e+/8XyfTO0SSESM
         /0pq2I6waugcE+mVBqfm8smSZHBHXUoziosT8AqpUv+RF9EvJ6mQm7gfPsf7x1Lf1c0O
         zQ16vXcqJ+Ko1JPE9vEAuTBDPadnRS4rTGPFQs/HaMi2TvRHW0WHLNdeW7hb+QQowhjr
         cTmP59cew8vSC7SI89pwWZVtb54T9xi1FFNQI1Y1CJUyTiHuhgRZmfwu1zgEKr3qcKEs
         8KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597059; x=1770201859;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP54E5Zozvp+1GAPNgjDcxymFAEsnkay7BW+MQRPQZQ=;
        b=drw5fKxcvkuzDi+N5s9oTU8cO1IlHonmxVnjrWhCWLiJaoW65ZMFoXaZgGNPlZkF+r
         jq4WfXkRqZo0MYpHc6bw7x3SnheboZXZYCYqvzWQMhsZjnBwha3KbDNkw2Y6BjUJcTbe
         O1w95u829c0YJCpaiPiWBS+dDPndMAR6nw863xene6fwWGZLklSJUOzgOo2YNyGgyofz
         iHwRocqLozvWij3doP+SQQZ57ker7rqQeGmbCoI6O5wof4xdjxCw6B5hv+gKayAnd5l/
         d2yBIYYnG4udkYXPKDvZduoSn8gsWc5cQd9v1CPM0mrLYVbv9VPpL6Sw+rbze+Oid3Sh
         eoZA==
X-Forwarded-Encrypted: i=1; AJvYcCVxL3rJliXSrRtOWAkEZ/vKf8rAVlu3zwSjy5Jy7QRCTYkHWp8j2v9lOQ5+1XjXxHhEcium0r1F7vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUaaole2cCBzR4C4lwjTnUCVa/1OO74xFEiLczXpsIiVPWJBG
	nS1wyIRXPzOdUkMNLqSDGWu0gzVwOnfjwhQ6df/kRvvzhwjrfgKoUmhr
X-Gm-Gg: AZuq6aISxzR9CDTW2hDRQbZNV5aMcJu9TkBnEo4cbrqg8JvNmdiK3SP00+qh7XlIrMh
	oeKltBVDcXQdh8QcYjX1sGehiD7H7ZD3Zvr8NO/qRCfvO+YOBJo5LUDq4PGbPP2L5Ez/tJcT3LG
	de3UB+fhExmwvGs1tzPIvDNVrat4clkOiH9TRBut9C4SsHitr1Db26W2v3PI/ylXEdVEQX31mwH
	CTDJXY7SZoujMVun9NQ8aM73mvezpyj/NY4BwPYm+1SBHSyn+XPsgZBboCsm8Ng8Tqi3LD2FQLG
	m12ZikUrAyUAvzsyU/6WoXySk04TnAhCqZEjGK5YCKSwpMUKw7rRveY5lK8FfxImJbrQUJ45mYo
	9GIam4uvh59xoArdJEMM3XlfBO7+Ci/0et2tXs4Vx0oYXpAujqU09AaHzysXfzBX9Ig3xdl7JRJ
	3LP+Uf8W10Rxrv9JcDTN6FmgiwWqXmIA==
X-Received: by 2002:a05:600c:4746:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-48069c5547amr64307945e9.30.1769597058510;
        Wed, 28 Jan 2026 02:44:18 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce564f9sm57099265e9.14.2026.01.28.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:44:18 -0800 (PST)
Message-ID: <be27fa4404511cdf65a9a0f212653a7f1fcd86b6.camel@gmail.com>
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Konstantin Ryabitsev <mricon@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tools@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Thomas
 Gleixner	 <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>,  Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>,  Kent Gustavsson	 <kent@minoris.se>, Gustavo
 Silva <gustavograzs@gmail.com>, Nishant Malpani	
 <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Date: Wed, 28 Jan 2026 10:45:01 +0000
In-Reply-To: <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	 <20260123113708.416727-19-bigeasy@linutronix.de>
	 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
	 <20260126081510.jr8Rp6R7@linutronix.de>
	 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
	 <20260126101034.lnGGQmUD@linutronix.de>
	 <aXdJbidb3DPyRaxB@smile.fi.intel.com>
	 <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-26 at 09:29 -0500, Konstantin Ryabitsev wrote:
> On Mon, Jan 26, 2026 at 01:01:02PM +0200, Andy Shevchenko wrote:
> > > I lose it on the next if I update patches in tree and re-export them.=
=20
> >=20
> > I don't understand this, sorry. Can you provide a step-by-step example?
> > Do you mean that you are taking previous version from the list and reap=
plying
> > it via `git am`? But shouldn't `b4` take care of that as long as it kno=
ws the
> > Change-ID and it matches?
>=20
> That's not the intended workflow -- the series is kept as a branch in you=
r
> local tree and any updates happen to that branch, so any entries in a com=
mit
> falling under "---" will persist across revisions.
>=20

Hi Konstantin,

Since I have you here, I might ask about something that I'm not sure how to=
 handle. Might be dumb
but here it goes. One problem is when I send v1 based on a branch and when =
I'm starting to work on
v2 that branch was force-updated and I want to base my v2 on it. Is there a=
ny good way to handle
this?


What I currently do is more or less:

git cat-file -p $COVER_SHA
git reset --hard origin/branch
git commit --allow-empty (and past all the cover with b4 metadata)
// apply my series patches.

Thx!
- Nuno S=C3=A1
>=20
