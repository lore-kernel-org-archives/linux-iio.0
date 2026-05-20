Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80453BCD05
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264876; cv=pass; b=WpKHXTJf4ZB4TCMX1ltZ2YTTuwFLHi+QcyvzXUOaxX9vc3ff1/cJSI4H2gY+2MGFz813TE+6EqXL+JqSqp2/sy4X9pt8Nz+I/GKxHV/Gt3E0ZeSBZwHcOtiYa0BL3G2W+b1mHctWWMiS78DRcZvR0UJdo0W5OOZqLm8emnEMKr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264876; c=relaxed/simple;
	bh=Asewp5IkklurDxOrc/bcwlJsHgUIXsfxcPA8XqIWGe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHxG2RCrGUuUvzRypCh07u2L6LrjXjBSdYsWHDKJky0eYxLlb1XF/Kv0FpjSWXMHnRrXb8CxVJzrE7OxNmy8n+V/LyAiTKbjFbDQyWYxt0DTEI1972A+vtld0SzfsQRz7UI4nF0jI/RLewmq5o0/xG2wCNjeXmAlPqk3raqECEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2ZzXB4t; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ZzXB4t"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso2226011eec.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 01:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779264873; cv=none;
        d=google.com; s=arc-20240605;
        b=d+v1Yn3qyMbIPJdTmhi11cN8FU7YIi7mGvENLWYlOnZ+PZu88ZxR4bR40JdZvxv08+
         YS9Xddo1iGlZ1H43dl4VznG5ZsQxVKJ8Usi1HNzIe3hO4JVZaitbOjYlISIleZFvd1ts
         5WwlSmbYB60GetYjoe3t3MqxmoDTFot8cwuEn29RSeyhNqc+idPYeQ2jXcRQF33ngHZv
         8vXpgIa8FJXTW1Eh6w8MZSOasLZ4PVp8siist77zv0dLKRwxGThpzLMQFQqwO6RXuyPG
         DX+RxfBeud2m6y7DoY4CbgXqJQk0abHJ6eHZcZtyCII1o+SFzEOeTP7XaKv4+4sy1GWr
         pEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9QI3FzjSrkZUMO8AJDBfSBGYeQxfHBb0ce/7GuMxMMU=;
        fh=2T6jL5UMjEXKTVFG5gz4jp+InSv3OMTk3aLX4h4XJkQ=;
        b=GpIgIlpmFfoJ3cL4/2aXUfPvPA8YRXhJbteAelH17Tb37CjRIa/b4mbAHL2Kf5fAx7
         53OpGGtBhwnR1w9ceHPmjk6KrOhyCpn9fDp1i6xO8WxJgzJvD4eCWxlGjla74oZ3WHx7
         56ZBOtCWHrrcWT4pQ8a9kN+IcfIPVEYp+Bpjg8A4mjSvE1/3lbexVwsJKYQhjZ5HJQQI
         9TtE/YS4uZZ+iHLdO2snkfbsor9QMViNWgkgZAKKTA/Ee7f21ISBeE9VVRgZ+vu83CrW
         ypmR7PTxLl9ccga0KmS6fJzPOf5oFFhIloxtcLQPELS7l+CvcgmlDcj+E0Oqz6B8Q4NZ
         xGjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264873; x=1779869673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QI3FzjSrkZUMO8AJDBfSBGYeQxfHBb0ce/7GuMxMMU=;
        b=e2ZzXB4tMNaH4owqi4MWPpiwReMAVbx+pTi5oQVZNXDqY40Punq1y8da32SodBT7c3
         BGLWdxnSeptPayppaOSP2NlvqHFbZJF+a2wBgh/ZSEg5byFVK2SYhuBZqvPk/F76gfKq
         oJStwGBHDCKkP0kdNsQD9GzezagGbXArgMZ4nU+Qvo2EaKCqLdQLPQ+jyld737fVswzM
         WBtRkzUFN7Me7UbhN8WIuU32gFkP21XCR3P+OCNHegaSAeAUJU2PiD+Y+bjX3SDpnkK+
         gc3Mwrdv48q2zYPdnunysBRqKsTIZA60T5SRafIlc10pOAfygXQUctCZexVJtH0XTKoH
         xqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264873; x=1779869673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QI3FzjSrkZUMO8AJDBfSBGYeQxfHBb0ce/7GuMxMMU=;
        b=lKMVf7GafZC95/5DTvtxqVpr4n0WwenZAUS8LOQCcsr/fLZ2w8+jkwfz6UnVCQK+bR
         qHYU3IiVZDzGWgudeaVOaIuSVWPS/77b64DlD+gOznnpaGkOi+nOSd/GqS/WvLGMfpfR
         I3ElaJ08B6FMGFHvDOdCjZ1JEfTrK5QQEsOo457TIWFhiNvTEX3fGQ/JwhiVCQBQLufL
         Nk1+mlTO+UyH7OVGaBiap7YAH+2+RZtf4UOX6ET2jhsCckVVd3sydNRxUSEBhVAWgyph
         u7XFff3pznfUSZmzwINDWj7/ETQuL5rIEMfP+u/ZucVR225PebmVNmCeXwR0lLigTLe+
         ae0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9GtZbHJuUTwA+ko3pJyfiPPuWAObbYIP4PLvO/QtUCbIza7OIZnrcw5dfN+VpxXBYsdO8McdJeT54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5yFmdnbOXo+BK7jAHgPeFINNuNewDL8NlHcdzdI+EMDlO9+K
	jLY4WrzTm3KW6FX5RaxeSrOdtXiQfS/9da9GfbE/O55OBFoplFM0jLQ3rvgxmCY7+5iBNAF7dnj
	Ws10u418iGTi1dzfVL8aYYrcdLh+CCzY=
X-Gm-Gg: Acq92OG6dAdrQpPwDyy3TPLDkRVif6ig7+Yk9mSLSinWTITW9DvIStk05/g0tA2t8tA
	cydvi/xQ7IB4/BSXv2fNpbsuMwlr30q2BxN4EoWqKFa74x6uhhQoVGR0OV5lQ7ehTG6r1spB4kZ
	32Nc+ZbjaI0SxIvDOR1Yf0fqt/QvpeeJFhg/2EZzK0bGVv+r6/huMDfF3DdtJT5e15zg7A3tFBQ
	7041Bqf94AupupybunK1vX+7Pa+i6Yb4NbtlG2GUfVQIwwsvXK8qjJhu2ARbT+siuX9lRoF56Lb
	mjCemHQfXOb0LTC5fNME3gUxuKrD6C/FwtvaEXL+5XE4YnRwkgUgG9LlFYDR3lUVSZwNcvI=
X-Received: by 2002:a05:7300:6412:b0:2d8:97d6:6abc with SMTP id
 5a478bee46e88-30398600887mr11111991eec.22.1779264873049; Wed, 20 May 2026
 01:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520072843.3593-1-kimjinseob88@gmail.com> <20260520072843.3593-4-kimjinseob88@gmail.com>
 <CALoEA-xOGAGb=-uXBv+Q2QC=viPCGUESGZw=rfoBHdEJFCkEAQ@mail.gmail.com> <CALMSewJinjbnHT_sOgWmHVeThv3su_E6fioyAjEWKzf7uROc2Q@mail.gmail.com>
In-Reply-To: <CALMSewJinjbnHT_sOgWmHVeThv3su_E6fioyAjEWKzf7uROc2Q@mail.gmail.com>
From: j k <kimjinseob88@gmail.com>
Date: Wed, 20 May 2026 17:14:22 +0900
X-Gm-Features: AVHnY4Kq2XtyygSWFQQZ9X2c6E-mcr62Ko-mVv54zIUpSpjvCRfd4kJUZScXQdw
Message-ID: <CALMSewL560vBTut2=_x3KVvdoqMo3Lmg3WF9jr-EdncCFNW71w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] MAINTAINERS: add Open Sensor Fusion IIO driver entry
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, resending in plain text.

Thanks, that makes sense.

I will fold the binding-related MAINTAINERS entry into the dt-bindings patc=
h

and add the driver path entry in the driver patch in the next revision.

Thanks again

Jinseob


2026=EB=85=84 5=EC=9B=94 20=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:07, j=
 k <kimjinseob88@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thanks, that makes sense.
>
> I will fold the binding-related MAINTAINERS entry into the dt-bindings pa=
tch
> and add the driver path entry in the driver patch in the next revision.
>
> Thanks again
>
> Jinseob
>
> 2026=EB=85=84 5=EC=9B=94 20=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 4:59,=
 Joshua Crofts <joshua.crofts1@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>>
>> On Wed, 20 May 2026 at 09:35, Jinseob Kim <kimjinseob88@gmail.com> wrote=
:
>> >
>> > Add a maintainer entry for the Open Sensor Fusion IIO driver and bindi=
ng.
>> >
>> > The driver path reflects the current RFC layout. It may need to be adj=
usted
>> > after review if the driver moves under a different IIO directory.
>> >
>> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
>> > ---
>> >  MAINTAINERS | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index c2c6d7927..001ba4ea6 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -20011,6 +20011,13 @@ F:     Documentation/devicetree/
>> >  F:     arch/*/boot/dts/
>> >  F:     include/dt-bindings/
>> >
>> > +OPEN SENSOR FUSION IIO DRIVER
>> > +M:     Jinseob Kim <kimjinseob88@gmail.com>
>> > +L:     linux-iio@vger.kernel.org
>> > +S:     Maintained
>> > +F:     Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf=
-uart.yaml
>>
>> All of the above should be added in your dt-bindings patch. If you're
>> adding a new file,
>> it's expected for you to also add a new entry in MAINTAINERS in the same=
 patch,
>> otherwise it creates confusion and an unnecessary additional patch that =
the
>> maintainer could overlook (highly unlikely, but could happen).
>>
>> > +F:     drivers/iio/opensensorfusion/
>>
>> And this line would be added in the actual driver patch.
>>
>> --
>> Kind regards
>>
>> CJD
