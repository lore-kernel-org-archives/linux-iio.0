Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E122E62C0
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336691; cv=pass; b=fTQtjVMe5Rb9+pCb/RGcYFok1jdhOU5ARrq2ii4XBjZpGVvBTz4jrzG6Spi4CKf6fAAPiHup41X+4lz6gCssGNQsugM7WgVqxyJNyACcLVk0tvcVNsTYhgvR4bDe6kGe8cOd0B3IcZrdky1xgNhdPBPNGFSfVf7yD8HSdC8iD30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336691; c=relaxed/simple;
	bh=Lt7NiTphIs/XpUhsNunI6JojQgG2X5yFO4MynzZxdHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe03iQMVY0vKadWZtyj5hesp/zB+tcfVZy0ZA/SG67DT1ylirujE1IZZM8smsV5qeoFTGdVMmgYHUre8QmTBfmDU2Kujq0ju888tp3NiOcy4sFcmu/U1lpOpdZHj4f6sNiXMzhNoMCoui7fAw1eDVwaMDEwoxOoRQ2rTTl2Wzzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8apWOCm; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8apWOCm"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so2171135a12.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 10:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773336689; cv=none;
        d=google.com; s=arc-20240605;
        b=PzNFv2Glrz2p1l5bXpxShmjDZd6p93AaGz0xt2cYGbUNuZ7Q2yFUHEDpc2BT+pZ3Y2
         0z+xBvQu1nM85t5qDpv+slcnqRSCN2B5s7DpR7eJ//N5xUOqY0uDKmp/hTWPPbt7eUdh
         YERA/+D+nGwpU0Q1sJfhc834XptGaYkn3JyucavMKhkH7ylKwjEWGBB0b+7IrC9wU74U
         UTbIE6h23LYB+qHb6xqXsFZDt0uIzx7LuHq27asBpotx9J8NP/Q8hhHuxwcftkD5y1Wn
         Bgo0vA4lXubQ0dLXIjX1zXax+PhwUaWt+GmWyCHBsQh5rr7ZypagygDlThMlBM83QJo6
         ro+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lt7NiTphIs/XpUhsNunI6JojQgG2X5yFO4MynzZxdHM=;
        fh=2fUbe+Fg/tOPyynsfm8qaewgD0OibxFupEc2sy+/Vdo=;
        b=BNIqRJefGwP7+9oustoNKlcz4HurMZ8+dLO7wBWGS2BG0S+BOSP1T5XtDeBYXA6081
         Ew4Aq5uV/3bX9NmiM9vH+lWXrOECdj98AIGTmi9q+vyScjZ6JJj1G1cWLRCkZRUQ8Exg
         ktLixs32Pk7FSHq2/HK4H4btNjK8CXX/Lk/Tpc738BJGcgw5r7No56NN/5VJTZ+HsnDk
         f1WlQZMxT/tV4cvoM6Pm7eokwGp23AyvpLUKJjTuugR8poShY8Y+MxHPij+yAEJszYhR
         Yf2q7WY6AJ/rZkcFUQZKehtoKhfIgcAyknGs3a75Qo3lKv2GkmO34t9ltfwwN3V62yix
         0H6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773336689; x=1773941489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt7NiTphIs/XpUhsNunI6JojQgG2X5yFO4MynzZxdHM=;
        b=b8apWOCmEaGaNU2zkvtLO0ofGr74yrQza3pZHA9h9r3T80MmlhX46W+ld7AgAOyHoy
         uKsrhhQrkgNjSr/xLYMQNxm343Oc5hrdMooqBufkOrs6c+JRuXRlKOj9TRGTMHGVwYTl
         98srtOpJplPW+bhAlSafemCBt/rbCHFCPR9/oKBJ1iVOV3WLvDGcJoWVtcop0D0v3vaU
         rvWWxhNikZZ7Ezdew/5grmUJB8UmhBltBCTTU4IkQGtenOmTGyWigJQu7u8W7GzvVJY2
         GVoRpoTrycPX3djVl4A4S2N1bKgY/9O56Hb4BNbVRRDKUKUTg0CtFL7tSdunAgdfI8vf
         pW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336689; x=1773941489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lt7NiTphIs/XpUhsNunI6JojQgG2X5yFO4MynzZxdHM=;
        b=iHbcLXbbuVDdJvBP9jk6hfB1hWIYbmP+UWceWAWUw1Va5cSZBpxP6YAwIitfN1e92m
         B1bq4gMF30qd4888N/T6VeTeWfpYCqd8+WG560zy7a++1ztGRTjtXvh+3V5aXQyiOcYn
         H2GPunvv5dAAgMi/69rlOAIzSP+jeSQgwDNXzuZ3gBSNFuQDUA40wJJV4h+Iwx3AINmr
         AXJvwtLzZEZvcg6y+E23O7H3jdRmbgKgYNWhX1/1GPGrQ5ZV/Ig3QVPVug09eyPWEVRD
         C0W6oSXRoBkOg5J9bYOiA67a0wVkZ4XzdBnLAdqohmxJk3kzYRWid2KEbYy+Cfh+4ft3
         nW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI0jbfct4KUS+FCXttqoTtqwVpDJrNbnahfyWdqD7dpVOd/VEq5sUEnyNISZrObwjkH++z2rZdDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKJnNFewlqvcvHf1Sdjb/4SkMfEa0E417B1koO01VL4BeVC0o
	Eni25Ju+p0uaUYmEL/I34Hw3U3UPWQm0Sp1UX89I7rT6W0ZHkxYScafh45Od0s3RHrR+4LCticy
	3kw1DnwHFsSJoxmPUX76OqnjmEnpMXHk=
X-Gm-Gg: ATEYQzzJGCBneFjfDYC/VZ4eby8ELxXvRIBE9Wt+XwRdnvRdEOnORw7TLtVpG4L4InR
	Zd4SWlyeb6xC+E6dvbyJKD3wza0FeuL8OtOEAseFp6o0EmOzy5BLxDTpJqh4iatT3NPlXmN0kP+
	zcy1m1vCHzGNxxUL4CYr4ax2SlRaUo/zCX3b8aj3RWnaUkSAK3XlHAhsT9LrhgTr8cehrVZED70
	Q5NVB3V7+qbnMt7O1InPYtjxzhD7DcRzYxrRUqp2i3hd8vQIEe3RubgWLeDCK9CbJxWVetPxy45
	ODCDFTLqakXgQhfgfbhy13yGcnavTBLvZZp90iDO1PxHD8RikIqtbwTIVkbZe95QhIv8uHelN+N
	vP8aLNK1eK78cUjwbeHT5v/lYi1w=
X-Received: by 2002:a05:6402:210f:b0:65f:fd46:3fad with SMTP id
 4fb4d7f45d1cf-663bac0f6damr137889a12.31.1773336688494; Thu, 12 Mar 2026
 10:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
 <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
 <abLLap9bN3tTXfD6@ashevche-desk.local> <CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
 <pndikb1kn9n.a.out@axis.com>
In-Reply-To: <pndikb1kn9n.a.out@axis.com>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Thu, 12 Mar 2026 23:01:16 +0530
X-Gm-Features: AaiRm52KifBCGc0RBslQXC7_Fse8QlTugSdTx8ZbF16QKNne_lvb4fYm4SlAmxQ
Message-ID: <CANS1UbhMH_z=e5KrmxQv+D9=_7YQL=g=qdxv9e86iRjZ7LF=uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 10:17=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.co=
m> wrote:
>
> I think "consensus" was met with Jonathan's mail [1]. You must've read
> it since you replied to it, or?

Yes i have read that reply, i am sorry i misunderstood your statement i tho=
ught
it would be an update in styling rules or something then i will have to act=
.
Now i get it.

> As I said in my first comment: put the changes into separate patches
> (sorting the headers is one patch and the `guard(mutex)` another). Then
> put all of them in *one* patch series. I hope this is clear enough...

Yes it is clear, i will add separate patches in the series to put headers i=
n
alphabetical order.

Thankyou,
Rajveer Chaudhari
