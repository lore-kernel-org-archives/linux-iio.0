Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BB3939B5;
	Tue,  2 Jun 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401568; cv=none; b=FyfOyQMUiytRN8np72/ZI6U4+bJiHFad7W2SQsKrOf/QQ8pE3q0PPD1l2HQVvqdnnXDi6l8YhG+giRMMhkCxFnGV2N+NDqolK7dRNHYD8IC1dpSVM2jYogwYeg3t5WgA7FM8d8FDbdU0irOAX+okP+SyJNh4dtbhGGiCNSAc2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401568; c=relaxed/simple;
	bh=9LTj386/a+Iv+it/X9E+SOvy9Psrkc0ZaGYlYVahIUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOfVkOt1k2pKmnO/afDZhMSZjX/U/b6gTKGwrRozNH/FQJCOBIHrvZiELo5bVSVUTtfk6fU7jBLEWDCttyogPKp4a2VTBCMbPT1EyZLdleLsuaw3lBP1UEdGKTKh/LNvxmbZqn9tgVU/BtGaAOl9ET0oA0kvCOucJye9MPn3lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4jWOoPF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4jWOoPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD94C1F00893;
	Tue,  2 Jun 2026 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401567;
	bh=QZZxwumbaJyuarHbUY4ZoK3cdKzarRWJ3vb08iu0rek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N4jWOoPF3decmWri7JTIYNE3txYdhW1r3W7WwTYMGErxDzWaULywiXYnB0e2dB4pr
	 tVmwAQ4EX0mi8qYg19bBXpgU4AkqRTiIAZwrIg/0wrlJoKL3UAEy7VqHl2D112OoAm
	 FbWgxLJbTSUltwBnwQHdvW9bdbRkMrTwBj6X4hm5FIouRDx04ygi8ySUCG5ciOmmlB
	 rnXRURZRoBaEBABluKm6s1ooSPg6/5vJ0c5PDm2T7hvOkG7Yz0ILyp/DyP1hy6D6FU
	 P6SC4dr2RAL3tCkgwmcVX0BQqSmr8LAFWOjJYCxEoPNyYBckCPUab664EPelS7/XLd
	 m+MgE3SIMejQw==
Date: Tue, 2 Jun 2026 12:59:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait
 for I2cClient
Message-ID: <20260602125919.4b289ce2@jic23-huawei>
In-Reply-To: <CAO26r3QLJ1ZR1Qfjr6wQo+e3H6v=Z=bxkeE8+nseajYgWLbi4g@mail.gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-2-muchamadcoirulanwar@gmail.com>
	<20260528162557.2b0b28d9@jic23-huawei>
	<CAO26r3QZyVco2aZRqPSyWr3d-SBAVEknkaeNDM4g5DFCr3-2aw@mail.gmail.com>
	<20260601100559.274d5b05@jic23-huawei>
	<CAO26r3QLJ1ZR1Qfjr6wQo+e3H6v=Z=bxkeE8+nseajYgWLbi4g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 15:11:12 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> On Mon, 1 Jun 2026 10:05:00 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > +CC linux-i2c and Wolfram - make sure to keep them on future versions
> > of this patch.  
> 
> Noted.
> 
> > If this was renamed to make it the rust smbus binding then I wouldn't
> > be as bothered by this. For something claiming to be I2C this is a
> > misleading interface and I am very much against it.  
> 
> Agreed. I'll rename it to make it clearly SMBus-scoped in v4.
> 
> > Understood that there is more to do, but given the regmap already
> > encapsulates the smbus support you have here, I'd be much more in
> > favour of the focus going on getting that done.
> >
> > I would almost suggest not merging a non regmap interface for what you
> > cover here, except we do get annoying corner cases where the device
> > uses a mixture of smbus like commands and non smbus so there probably
> > will need to be support at the i2c / smbus level.  
> 
> Makes sense. Will defer to Wolfram and the i2c folks on whether this
> should wait for regmap or land as a clearly-scoped SMBus patch.
> 
> 
> > Is this separating a safety argument from a bug check? If so why
> > not just use the tighter one?  
> 
> > +    fn maxsize(&self) -> usize {
> > +        256
> > +    }  
> 
> The try_read8 here is a general SMBus wrapper, not AS5600-specific.
> The u8 command (register address) applies to any SMBus device, so
> 8-bit is the protocol max. If we tighten below that, it breaks devices
> with registers at 0x80 and above. The 7-bit limit applies to the
> device address, not this command byte.

Ah.. Sorry, I was being stupid and had forgotten the meaning
of the address byte (which device + that magic r/w bit which
is oddly in that byte).  I even read wrong section of the smbus
protocol description as it has both read byte and read byte data
only the second of which takes a command byte.

I think I got thrown by the generic naming of try_read8 that
doesn't capture that distinction but given it comes from the trait
I guess we can't do much about that.

Jonathan

> 
> Thanks,
> Coirul

