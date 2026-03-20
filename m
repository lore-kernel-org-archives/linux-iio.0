Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F92882BE
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017905; cv=none; b=VMsvv5z55jRRMkjsinwNkZCfMZreFuPGlM3JGSCjd8ZPZL6AdZUD5uSzUDBhQQ3WAZmUxBWVHcUjobVvG8Eg07Iww0FwnGS4viW+x5cw9GrYSg5a/qszrRnqagyO7K5bhi2E/nzP1jZtPnheN7+J7RhyOhWWO5PqrqeGaeVDRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017905; c=relaxed/simple;
	bh=OTEFC0pinOqu0Up5UTAV4E3idzdTkrkojT3B1LPYHqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufvZnpH8YPkEEIAcLtJeYVw2dMDcWoigqodmlac5bl93ma1vayCoqfCXV+ceB0LC1G2OQZT9cfvXm2tFQ13qs12plI12MxTNcv9nUNsuFnd9OsDY753QGVFWMMe5ZU+eds6b/618KkpMlMslrD0NV5+B+QcRNQ1bU+s8FA3/uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLDO0jRp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLDO0jRp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1451064f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774017902; x=1774622702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gFUsjpYnjCYoV2M+WjbPtxbeZtMIDawjXJ9ppKzFTQ=;
        b=aLDO0jRpXdI2vUdK18Zj7Kk9yE1aVOxIxettrXWHj3mx1S+AkwTd8yarrn5Z02ndRV
         KdZNS8osJfbFMLejckNXHyqVVbBR9ouOs1/4t9+OX7WImVtXbr+WmXfhWrnlVhxQoNKv
         Rr2hcKn1Mc+08G6Ak2CpeIsAxoZBwyPn24nbjrI79dhebDPrlBe7QAY5N2c4tg9pww/j
         hF9RVUOUahXgbffq/C412Xa0ZWlVo/KUhy6AXOB85H7P8uOIFhb7IJhkl9Msqk1oSI3E
         3MVUcWUFhDTmEOlBdaF4IlApV7xsOW8pRZLxFa6/+wTUvtMzc+7e7Dy87YhzzuZ5BEEp
         xElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017902; x=1774622702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gFUsjpYnjCYoV2M+WjbPtxbeZtMIDawjXJ9ppKzFTQ=;
        b=ZxOsE4E3QqT0+Qk5tn69yavzWUZu5G3/IMSPg2VH9t4uePLJhyGtHS9yZbgLoTU4uo
         R5DnH86jG9Gewq72omve77M8vwf9aNTuztBen+nhpckrdRT9pjStDBIqYCVPPz7sEwny
         aY1sAtwEYGGz5iNDsB7I0K+LNGSjYTl5lC0s+Gk7nvk149ugb94Nk1gbmAnP02cOsvqe
         5k7Zd6/22J+vQstP+7eWywrGb7RWG6WlDkEWef6WG5M6jHkhuBxg/3WMgb+eRetEtKxA
         HTY7MdvYqBObEBzoxj/g+fUJ3SndST3lcXh3Y1bDWvfQ0vo/Ht0DiN3YllscXaZ/mK+h
         aKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCULlBGPYdRCatu3ajpy+F4aw8Lc83rE6Flp1/8EJjIdBr7D0LGP7/fjBd9hCvyLwru8h8EKaW2HvCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqz1wpJ5WcV0inTu3iu0w4D3wjXhkNUehBo6Cz3No4KkdgUj6
	hClqXWBmWCkjigXsLXyiNVyEoeEfMcgKI0YZ0ku8NyiBKKaP0VF2lwBz
X-Gm-Gg: ATEYQzz4LD0wzrAzkOux5irVz437xX7rFQPn/9K99JZ2Wvas62dRf3FpmBgfEb3Pnui
	8Ghb3hE8RKgl3QfwSJAr8PFPWl9mt/bIpiCLUwtGTHCexWIbVfi4o+mvqBa34Ah3DZysP5EiFHZ
	p9acH6FxmhWl/47kXT28I4MZnx30Jtu5sQpyiSqo+ntJTNG06s1gRl4kv7l67+t307IjmA1zH18
	v2DbkBnhX3lQh0dZPc/6vHz+Qk9Ml7XKCEXy54xpX2TS6nO17O8oGb/QU3NGhMLnIfq91jxithH
	bZeO3GOH0gGNlT6j98aa7wSp29YNLLpXUeLi3sBfc9elatQQZNGda8MDa/c2o45GGugI+xbBGCc
	EnvTMBtDWSMmX/ptc8VpZTlnhBTJiCBedA5kP+e6XZSyzykIY1ZFb7bIxRvWoeGwU/hB4TiJa+z
	mRUwhLG+dsve5edx361z2TgMD1712k7fJVTFb+bd+x+ld3vuFVpfBuL0RzpeUJ53/i/KIpr27dM
	a8=
X-Received: by 2002:a05:600c:548c:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-486ff027176mr52957895e9.17.1774017901787;
        Fri, 20 Mar 2026 07:45:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700658441sm72115895e9.4.2026.03.20.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:45:01 -0700 (PDT)
Date: Fri, 20 Mar 2026 14:44:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <20260320144459.705c8e60@pumpkin>
In-Reply-To: <qsquhriyrepndxwexox35oi5i7v4klb64lajuk3j3pfozkjiew@fp55l4znck4o>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
	<20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
	<aabm23jCikXs1l6F@ashevche-desk.local>
	<qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
	<4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
	<rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
	<ab00clb7LL-bmJWe@ashevche-desk.local>
	<ixvzb5mni2lhz733f4fvvzhozmpezkx5s2q7sash3wv3u2g7ov@pgs6pve6kxrq>
	<ab08aHbudFWEtLi8@ashevche-desk.local>
	<qsquhriyrepndxwexox35oi5i7v4klb64lajuk3j3pfozkjiew@fp55l4znck4o>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 12:41:57 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

...
> > Some (stupid) thoughts loudly. IIUC even if we implement '%g' in scanf(), it
> > wont help you as you want to have more precise values. Do I get it correct?  
> 
> If I am parsing 3.14159265359 with 6 decimal precision I want to stop at:
> 
> frac = 141592
> int = 3
> 
> and ignore the rest.
> 

If you add an 'upper limit' parameter and return a pointer to the digit
that exceeds the limit (which would normally get processed as a syntax error)
then you could have:
	int_part = strtoull(pi, &end, ~0ull, 10);
	if (end[0] == '.' && isdigit(end[1])) {
		frac = strtoull(end + 2, &end, 999999, 10);
		while (isdigit(*end))
			end++;
	}

Passing in the limit should help strtol() are strtoi() as well.

	David
