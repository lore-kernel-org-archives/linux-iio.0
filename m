Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996373;
	b=hMDyOO0Yf/P3CjwVReTKyGidlFgcEcf2fckcj21KhauHMI7lYJ9Ee7Svembq8/oV7IFa
	 Xe7rzepRv9XUwBJkvPcbYgSmK1h/nL5H53dJdvtiV+wdeloC6XhwH+VMCjQ4x0YKqZXZi
	 cs+PrRnXxpqaW2VJgecK3y3lhpGQI5lsLRetEAnsL3+3UTiQsu25UaopF5LFw3qlqvpFG
	 qGel9/BHr53sjEdSFIz044eafsOqnANyRqnKEkpacJRSilMO5H8IJ7AcTNKP+6Gdr7wVU
	 cP/TW9HV7fb3LseyR+Z5l2+K0MO6zBrFZje+F2Yn3cLcplMGunlGtHbWT/dhoN028dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ptek3L7MaoTJgYqQCUXK+3f0qzxCpv92OLf/1V4Kc8I=;
	b=UZDwNajvIWoOId3MEoesL+XB/l9KnKTqV7FX37fTAIxncfo9f8P2KVYupGVWBjdDyjYQ
	 8uhtAUdLxnBqbaO1XON9nddL9Ah2W7HE1fgLrfF01OVMxm6Q/2ut1QzRdUaA/5PNbhTgQ
	 BJ4+WeFlIJYsEw3fyuAaGsw/5zaK0V+HU5lCpySMGGp954EGtwbiC/e4HN3JAdp0swsO0
	 tWKABl7+bJ3YV9GFzZfcR51cofRANcR0uOqy74iP5n6GszLwRDLOKs7qCJ4p+mxI5XpgI
	 Q/J8i5LE+EEWnR/01kZgiCnPE1lv4eVQhuPG5RGcEq6MgOvq1oHH/FQTkQXSFabNbEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ssWMbJK6;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D14606A320
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 10:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16D14606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ssWMbJK6
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so1203394c88.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 02:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996372; x=1795601172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptek3L7MaoTJgYqQCUXK+3f0qzxCpv92OLf/1V4Kc8I=;
        b=ssWMbJK6tykegP234zTQmP4F8tfX+bemU0xjgrSDP+YQ6xxrOkSPRg/x2RUkfFS4Zt
         IgzSR97X3AV6fyvNMdi0/w1uJd+ogztf9QjS4zA9R2Wl6vql1WH2TG+mNv6vYP+4y7II
         n48d8UDaqOYXkv2SjvMSmg9AtnrXVJD39NkadvndaSPNhH2F0H0Z8j/omU2lDBL/ZL2X
         CMCU02mCcrhVz97Kc9DY05+zJebJ5jlVr42/Ymx/j5+/arx5t7Waxqq8XCzf51TahMwt
         MfsHu3dqm1dEYyAgTOvi1HdsypYrRqWQhrEDHdLfLitsywvwCOWKGN0LthWE6GNNcYEI
         +64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996372; x=1795601172;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptek3L7MaoTJgYqQCUXK+3f0qzxCpv92OLf/1V4Kc8I=;
        b=ceqsggHp+7y4ts8RW3jsKpxTU/NTlxqq5+Z0LT66Ld2cjpFhQTmwQUd3JvMsP/abNs
         GyQen0mOUljm4wDvgpSpnM88xgSqsHmZ28bEPXd1KI56YAKLv3ycL5sNfn2A41/J8ksr
         8kZ43KE7rnQD8y/C+eX/FkBLUMn6a2yb89FYlct+yYzgOTWMEGIt05Koo67KFls7Ea9J
         cWt5xKlal7BOiWNWZmsexU507uTtJF5qfQeHe0pobBq08DS/KTD35Voz2G5/18+81MJK
         KglY4ACG448Mes3meZRA6LqNqtPEuaQdbs2dMJ5UZEO1hDudGk4D42oPRd7URbnkH8BR
         7WtA==
X-Forwarded-Encrypted: i=1; AL+hErGRVykzxPodVNT5RzTVrvTtPVRfTIO8cJGnRo3OPRW+IhzyICW8fvDAwboeyCG3Hy6NR6bFarom6Kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rAz46kHIRoJh5TOUiaIGvf5+LAdRXvrxaHEuI+vPtxm37KWWA
	NvYONkMxDlUUaLGq3sMidHB64dNobsOt9OprzNpiIN6+kKlWBThpxgRS
X-Gm-Gg: AYBFou1OtadKG610d7A1VoSJtMk6RpR9lSPAByv60A36IFYu0g92dwxc5Cf9lIZ0aPd
	raWMV71FRqQsvobEepElc1DTECmSCkoV6ZPvUzyDEJeiMn+U2UGTFKsytW8OJCRVY+Kdfj5TKZ3
	EfY6RH+WfM/RYAx0Vh3qSKSIYmAaYA9yQQjZQfA9OLZCFa5CugpjjIQqYpINuF5Nh6Qigx/DE2j
	6v+826b1lQdpQikfCtYLr03l+QLVD9zd12i8OVLx9MWpEnxfqai35o0JKy7H3dRmK74qnfi8hhN
	/eigqyC0j+qhtZRPXPpZwDrvSkq1BruKpbk5sCz+oKnq59Qpb32JeLTeueeWs0z34R7yY4lYMFq
	UISNXSflnGfDPGzrwcKRitDNaOEYOKpCtvjEiHMTP68sWOSe3LAO06Cxyf7d0IgDD5bA6vVfKeR
	WVJlCVdwwyPwTiYkUclrrWdcg9qRBlSyN6m/IHeIttV1n7UT7VG1HUXzvNlk4omdbHImaTDUk0K
	8EeJhZdK3WoP+JNCPNUq5ecOdDWALCZB3cIA46S//77tLUKLRGpZwsZbTyUESRVf1VTfrohx0Gg
	ynGG+gsWTalZ/RPulsdUucwpDwEHRjMHNLwW/5GnEJ6ey0eqs8ckAMKRj/tXnub8HvU8ODN+AIV
	85PU7gaE7JHR0u1evOZWySFfzk659mZNFyX0PscXEiSGGQt222aEssYb3OqSi6cu24SziytUz2b
	CrhIWzW3/90PQVt08+WPp4McAbSOWyCcOwhlR8pgUWBWwztGw0pHJsbkgnZMADVAw=
X-Received: by 2002:a05:701b:424e:20b0:1b2:649d:dc23 with SMTP id a92af1059eb24-1b543d2e78cmr2418396c88.35.1794996371898;
        Wed, 18 Nov 2026 02:06:11 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447811efsm5392670c88.3.2026.11.18.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:06:11 -0800 (PST)
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
Subject: Re: [PATCH 2/6] iio: proximity: sx9324: fix proximity threshold writes
Date: Wed, 18 Nov 2026 15:36:05 +0530
Message-ID: <20261118100605.34002-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av1NN8_Y_f3xtWRo@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com> <20261116205320.26070-3-kapoorarnav43@gmail.com> <avyj-lOGvj04A_Ak@ashevche-desk.local> <20261117191029.83901-1-kapoorarnav43@gmail.com> <av1NN8_Y_f3xtWRo@ashevche-desk.local>
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

On Wed, Nov 18, 2026 at 09:01:11AM +0200, Andy Shevchenko wrote:
> For the sake of the correctness the whole set of 64k has to be checked. And in
> most cases the + 1 there will be wrong. The only correction we need is on the
> edges of the full squares, id est when val == r² - 1.

I ran the v2 logic (reject val < 0, int_sqrt(2 * val + 1) for val > 1,
reject results above 0xff) over every val from 0 to 65535. Values up to
32767 are accepted, and for each of them, apart from val == 0:

	code = largest r such that r * r / 2 <= val

val == 0 stays at code 0, which reads back as 0 like code 1 does.

The + 1 only changes the result where you say the correction is needed.
int_sqrt(2 * val + 1) differs from int_sqrt(2 * val) for 127 values of
val, and those are exactly the ones with 2 * val == r² - 1 for an odd r
(val = 4, 12, 24, ..., 32512). For every other val both give the same
code, so the + 1 has no effect there.

The reason is that, in integer arithmetic:

	r * r / 2 <= val  <=>  r * r < 2 * val + 2  <=>  r * r <= 2 * val + 1

> At bare minimum the commit message needs to be corrected and explained
> these aspects that while the + 1 gives wrong result for most of the cases,
> it's still okay to use as we work only in integer arithmetics. Also the formula
> (r² - 1) / 2  has to be dropped as it's incorrect from mathematics point of
> view. The floor() happens on / 2 and has nothing to do with (- 1) correction.

Agreed on dropping the formula. For v2 I plan to replace that part of
the commit message with:

    read_thresh() reports code r as r * r / 2, and the division rounds
    down for odd r. write_thresh() inverts that with int_sqrt(2 * val),
    which is one code too low when 2 * val == r * r - 1, so writing back
    the value read from an odd code lowers the code by one.

    Use int_sqrt(2 * val + 1), which gives the largest code whose
    threshold does not exceed val: in integer arithmetic,
    r * r / 2 <= val is the same as r * r <= 2 * val + 1. The result only
    differs from int_sqrt(2 * val) on those edges.

The same goes for 5/6. Does that cover what you had in mind?

Thanks,
Arnav
