Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756897;
	b=RaMfkqt12aSNUEjXL+i7CEkbQO8jrRH1HewButMGl55jzU575wvszsUXGAvu0/JktuzP
	 QvAJgoI0K2uz5MyQNHhVnfFxC5W/MfyfdOB4s9ILFiH/Sl4FxG+8In7OyHC6IjDuem7hg
	 7kRZPOZ7JvfjAbhGGoPO2JHLgwGi3aL6U67zjwt5ApnEnTJSqOZOsJw+iGRycr9k+rb5r
	 d9781LDGdq03HthL7z4TfnhFh2f+wr9oaYvdcs1fIGbIkNP3HgumV43VUUh22whhyHLR+
	 hCdhlrWF2lwts8ppJjWJe19RzzCvO7ql1c4v8k42XrWgF7g9JC40umhI+pg+peDdp7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756897;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QyFBrT3W/KJfm2VNPVTE0rU9qrI5bDLSgmmBzoZy2vo=;
	b=ONSsbh3hOswBQtoVWkPFVgYkSG2zpYScF5T0SSi2/6xpHbEN3L1HcqNpc9HHPuj3JttB
	 cI7VCjlyoY8iJEH7DxvHxoDQg+6OEzuXL5/B1tUotSfYnwaYamhZkmyqn3KHPzbEeabmj
	 h/NZVPL4ADO932VRzuQS8AZsHMRjCYhs0oumnrxQycJvKVK+X8s4RzVLZ6CFiwZVdzzm1
	 SdFyrH5mTcB7U2fCKi6+2fMvYingqRfQ0TBwpll63qwI0CGnq4sC7s6qkMxt31ZhsEqqX
	 H+bxAx2xBhQbPNACIxbJ629gAxSma6SpVi3jPY1BmtT5Rqn3NRZtbXA2ueeEX70h2QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JExwITc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36746606A31B;
	Wed,  4 Nov 2026 01:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JExwITc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED341F000C1;
	Wed,  4 Nov 2026 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756896;
	bh=QyFBrT3W/KJfm2VNPVTE0rU9qrI5bDLSgmmBzoZy2vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JExwITc3RPXGZzLErEVSv3uDOgZwOgqQOPVdkHY5WjdsizvYos12+BBhXreZnIsPJ
	 arLCxKsNuMnvUvOJinwNLHePub52z15nFSuQbEvtRnnVGP4a3MLQ/AlDDoUokeHyMS
	 9ca/BAD5LwesYwQnSmZmhlx36+IGzyUGr+iICO0vzmJLzIc+TbVCW6GnIaLidEf9Xu
	 STCEPNa14uczydI12JJnhgvros7gubpbgYKBSal9iRMd/9n84i30tGBiyMytYPz15P
	 YW1mNETsGn5xhsSGt4jfQ2vgW5b9pmSLkeEehPsQL8EYaD615kd40YVuVkaj4Wqpo8
	 WBM7da/I6qv/A==
Date: Wed, 4 Nov 2026 01:48:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>,
 raffaele.tranfaglia@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: al3010: fix out-of-bounds read of the scale
 table
Message-ID: <20261104014809.75e92a17@jic23-hlaptop>
In-Reply-To: <20261103140055.00000efd@kernel.org>
References: <20261103-al3010-scale-bounds-v1-1-6110c2ffe3b4@gmail.com>
	<20261103140055.00000efd@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Nov 2026 14:00:55 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Tue, 03 Nov 2026 08:42:48 +0000
> Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:
> 
> > From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> > 
> > The gain field read from the CONFIG register is three bits wide, so it
> > can hold values from 0 to 7, but al3010_scales[] only has four entries.
> > If the register holds a gain value of 4 or more, reading the scale
> > attribute indexes past the end of the table and returns garbage.
> > 
> > Reject such values with -EINVAL instead of indexing past the end of
> > the table.
> > 
> > Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
Dropped the fixes tag.  This is hardening against buggy hardware
rather than fixing an issue anyone should encounter with a correctly
functioning device.

I don't mind such hardening (when simple and maintainable which 
your example here is) but I don't want to mark them as fixes
as that tends to trigger backporting which may not be appropriate.

Applied to the testing branch of iio.git with that tag dropped.

Jonathan

> > Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> > ---
> > Found with LLM-assisted static analysis of drivers/iio, looking for
> > table lookups indexed by unchecked register fields; the fix was drafted
> > with the same assistant and reviewed and tested by me.
> > 
> > Tested on arm64 QEMU with i2c-stub and CONFIG_UBSAN_BOUNDS=y. After
> > writing a gain value of 4 to CONFIG (0x10), reading
> > in_illuminance_scale:
> > - before: two array-index-out-of-bounds reports (al3010.c:137 and
> >   :138), and the attribute reads 0.000000
> > - after: the read fails with -EINVAL and no report is printed
> > ---  
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 

