Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE579299923
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705053; cv=none; b=t316kuOkP29xQJYM0O8Ua1gRa601ZQzS1xFjQ7Lw/flmwaQSb/b/AmR2aN1iAcpbZVi9KvR9FXqXmA+3WsxI/AB5clPt0vg1XUlApySRnBysin+md5U2Nd0WJwDJdB1ihzf0B98MTSO4lYPOdh1SnfYmIwrGtCaeSo894oazm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705053; c=relaxed/simple;
	bh=utb8PxUAQ21IQGDkeCLP3Nrl6lFjdmkAk949vvRVAE0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EHEoqNxbET1pkIKOw9CqgRkzfHWd6InhrXy6xzDr5ECeXcyRnwHdNhz28Uqalg+vCI3c2GftkhVzEux2FiLnknbb8x8apSoTGdD3VsC42pYPWg43p50Mbg1tBpXiTvqsxQIZuWro101CZ2Trhf3mXGDj4gPsP2KfEybs9dWAIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INiy8UQR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INiy8UQR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c80170db7d6so2867563a12.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778705051; x=1779309851; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCVwevTrbyLjyeQl3sspspHpkcp4yNudK5glbIfDxdM=;
        b=INiy8UQR1f7J//L6PbQVdxQ2uRzGWCLC4OUrT4s3RUjn2KfCyClCwJUmSc4keTpxKw
         TiD4t7tfGBnasffm3habMD1fHcU/56v+mVGvEptA38HhCsWze0mVRGHn3YEYZlZ+mlXD
         tdznfWuMNSJBtfxC94RQvmGhNK6H2nzeyeyl6vEwDQh36PDf53G2nKv+KDCY42gStcR0
         djXzysVCxTn76Wn6Hkoy+UFpl4hBd4dmkdrQfLaByvACwx5xYD73mbdDubrvEtBhmIU6
         rFr8RtKIq6cU7b3/IVWao7iKc2n1Tpw+iBN9UHqODinwLYBxdutQ7iCfGhZe/U6Ka5+n
         ic2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705051; x=1779309851;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCVwevTrbyLjyeQl3sspspHpkcp4yNudK5glbIfDxdM=;
        b=MRQHqvE4huGaoUWLFAtbvGWYjHWwGIfCKArCvCajyDEx4vedE+c8JqOaNgwXltcPrJ
         bRk4+b3RIQneuQt1an4pJljS+OoKmSPmbuPKRx9/bkpHBLZOfZ3tzQ+8FtckH8wYldm4
         3AMbQ0cVAdCx0GhVA4kDDQYK6d5WkymTzB+93obEj+qgWPBTzTDgeJphaApUZ0REt09E
         PmoIdhoH5XchyB84sskjjSYh+mtc8/Frtyx6dnkHQ4ef5ivtioNFmrDbMwjhyJJ3u5mW
         FibSK0mwkYWmKS8zEUVlqTlJQlZmfKvSwezWSgGcW3x8KqxN/YHKky5PJ4FjJUMmKKaK
         fmDw==
X-Forwarded-Encrypted: i=1; AFNElJ//OH6fDXPdAAGAx0k8jSkzb6kNT0Cn64URlKkUKyOuUPb24d7Q6Y/wcKoRURF0wpml9MP+U4M979c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNXjG8E+kGIckYQrTVhRVtAsw0vLhikloi9RaLwdMuoUY4tXW
	6PYG/ImXpgYDZUgchGo/uCi0LMj+2GVJUvCT2MFpT0KZ8BkL3SC/DSD1
X-Gm-Gg: Acq92OEmPoEABGdsEhkNwtjPBHCitNxI9khm11PTppn9PXF0YKY0Q+YVv8q8KoegV4M
	1eRfTqMnK93+d/kosgwp9851Y66XxYrwNrvULGtz0qpui8Rxl9MP8n+sKrbUrH9i3BLQaDOaOGz
	RqlaC14dcI7bbjXo4YB6QwQeW2NajisbmsweSh+IkBXLErAOst5f40oxNKqa9BjU+Arkh6zM4xO
	Vlbo4qvZ6NEzSOdSbSgA7aSJYFHeZ4Gm9jE/PBwuwHHHK2Y7YFgmnrRVKliHQzGOyGtcVkFN7Vr
	CnLNkBVyqdVwvDBv5ULwoT2O2JlgMow2SOOTkMeRzAuChCH4+b/FXpOqPlEc83Bx73mWL6wf+Vi
	lc6zrzW3SWChXM/un44KNJ/SmTrEVc4eaiJZ9G5/v8isAvNZY5F084NoUaYQ+HpBe7x9ysSto+V
	sA2sej1m3erYPrHDUQuW9GT0cxHTcmxmmQ5g==
X-Received: by 2002:a05:6a20:9188:b0:3a2:d79c:4159 with SMTP id adf61e73a8af0-3af82786dd4mr5739325637.32.1778705051152;
        Wed, 13 May 2026 13:44:11 -0700 (PDT)
Received: from localhost ([203.99.159.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660f9sm485790b3a.10.2026.05.13.13.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 13:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 09:44:00 +1300
Message-Id: <DIHUBAWF7RQ4.205UNZAU31THF@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
 <agS5Xu8ORtEwuwOB@ashevche-desk.local>
 <DIHR47ZGCUOK.2CNX05W0I8F6F@gmail.com>
 <agTY71MPPJ1b7qLC@ashevche-desk.local>
In-Reply-To: <agTY71MPPJ1b7qLC@ashevche-desk.local>

On Thu May 14, 2026 at 9:02 AM +13, Andy Shevchenko wrote:
> On Thu, May 14, 2026 at 07:13:41AM +1300, Javier Carrasco wrote:
>> On Thu May 14, 2026 at 6:48 AM +13, Andy Shevchenko wrote:
>> > On Wed, May 13, 2026 at 05:49:42PM +1300, Javier Carrasco wrote:
>> >> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
>> >> Use the correct channel type.
>> >
>> >> This bug was introduced in the first version of the driver.
>> >
>> > Unneeded detail, if it's a bug, use Fixes tag.
>>
>> >> When at it, fix minor checkpatch code style warning (alignment).
>
> ...
>
>> >> -	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
>> >> -					0, IIO_EV_TYPE_THRESH, evtdir),
>> >> -					iio_get_time_ns(indio_dev));
>> >> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> >> +						       0,
>> >> +						       IIO_EV_TYPE_THRESH,
>> >> +						       evtdir),
>> >> +			iio_get_time_ns(indio_dev));
>> >
>> > AFAICS the indentation is still broken. Why not doing like this:
>> >
>> > 	iio_push_event(indio_dev,
>> > 		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0, IIO_EV_TYPE_THRESH, evtdir=
),
>> > 		       iio_get_time_ns(indio_dev));
>>
>> Thank you for your feedback. According to checkpatch.pl, both variants
>> are fine. Mine takes into account the indentation within
>> IIO_UNMOD_EVENT_CODE(),
>
> And still have broken indentation with the last parameter. So it's not fi=
ne.
>

I am sorry to insist on this, but I beg to differ. The last paramter
(iio_get_time_ns()) is properly aligned as an argument of
iio_push_event() and not IIO_UNMOD_EVENT_CODE(). That is exactly my
point: with my indentation it is clear that iio_get_time_ns() is an
argument of iio_push_event() and not IIO_UNMOD_EVENT_CODE() because of
the alignment. Moreove, my proposed alignment (which again, is fine with
checkpatch --strict and the original one for example wasn't) is
consistent with many usages of iio_push_event() in existing drivers. I
just checked that there are dozens like mine, being the majority when it
comes to this kind of indentation.


>> and yours only accounts for the indentation for
>> the arguments of iio_push_event(). Moreover, your suggestion goes beyond
>> 80 characters and mine does not,
>
> When it's about readability the 80 characters is not a strict limit.
>
>> so I would prefer sticking to mine if
>> possible.
>
> I recommend to reconsider. Mine has no indentation issues, the only subtl=
e
> "problem" is 86 character line. And looking at the result I find mine bet=
ter
> to read (hence the exception may apply and we are fine with the length of
> the line).
>
>> As I said, it passes checkpatch --strict without warnings
>> in both cases.
>
>> I will send a new version adding the Fixes tag and removing the comment.
>
> Make it the first patch as the currently first one does not sound like a =
fix
> to me.

Ok, I will make this one the first patch of a smaller series with the
right Fixes tag added to it and removed from the other patch that
affects veml6030. I will split the new driver in smaller chunks and send
it as a dedicated series but continuing with the current versioning.

Best regards,
Javier
