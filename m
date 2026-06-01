Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EB237713;
	Mon,  1 Jun 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304769; cv=none; b=MTJ1GZGfDsurWTZZA4GYqCpx+FT2hH+HysPLfHFKyH1y85081jnXbe7Fcegw2mPa0OTi+Rl8JQmqCE1mK+VfGeGgnCEltn+puUShYQUvV5asNmdEIcGqNr/rob7lihyfLzzJ+JvJQVSBpcMcoLB6scQd7+x+m7DV015NrC4H3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304769; c=relaxed/simple;
	bh=7kzAfxsEPCYLC+Bp+qrmruizE4STjl8AUJd8xhBCuO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoRotUgQ2kSxOenG/7te/lAuii6EPKSpjUQPwwyjmZ1e9oZJNEltdLmid2CkeMdKOo5CJM54YRCia+6ZwUOk+6RdcDMs9GBD+dCckTqRefWd2gShXeyvcpB8NAoiBugULGzdAKANpoNo8I+3M5sl6VBIb8x/TebKrGBZ1ayOSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcYSV4ns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcYSV4ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CC81F00893;
	Mon,  1 Jun 2026 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780304768;
	bh=tFOKq5EqYzZOwXMsIVi6UJJc0VwMnON9Iu6xp7zFaDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WcYSV4nsim0OX7r6CI37fKPBaKhS+rl9XxG6/EXXOrcGHPj7jzqXa/VFPEFKS/7Cs
	 JQ1lr6BDruXNGrgoKY4rKp0Ozttyjl+r9KsLOKbW3AZhlzU4x9gI7GcaV6FS/0B7hL
	 2aV4TbWlpjvRhqulPtQbo5ksuL8SvDquU6i9l0GNyMkeaVoFRK3KDUS/JH97wP7U7I
	 aoXlE600YbBa9NntZR3J+AQzCAdRCAB3MBiqvFSjoN5YKmbU+ADOcf7ywa6G1PQifq
	 EntdNjLzS5r3D6C/cbGQZYKjPHCwzh9gN9M8drjSGNPRUtlvZv8aiPVbPtJP30t1LA
	 lNnJTyHDfwpNA==
Date: Mon, 1 Jun 2026 10:05:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait
 for I2cClient
Message-ID: <20260601100559.274d5b05@jic23-huawei>
In-Reply-To: <CAO26r3QZyVco2aZRqPSyWr3d-SBAVEknkaeNDM4g5DFCr3-2aw@mail.gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-2-muchamadcoirulanwar@gmail.com>
	<20260528162557.2b0b28d9@jic23-huawei>
	<CAO26r3QZyVco2aZRqPSyWr3d-SBAVEknkaeNDM4g5DFCr3-2aw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


+CC linux-i2c and Wolfram - make sure to keep them on future versions
of this patch.

On Mon, 1 Jun 2026 14:58:45 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> On Thu, 28 May 2026 16:25:57 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > My main concern is this currently takes away the clarity off smbus
> > naming and replaces it with the impression this is how i2c reads and writes
> > are done in general.  How will this support other forms of access?
> >
> > How do we have lots of different types of i2c supported?  Simplest being
> > the ones regmap supports today. There are 7ish in drivers/base/regmap-i2c.c
> >
> > Or if the plan is to only support register style interfaces why not only
> > allow for use of regmap?  
> 
> Some context on how we got here: in v2 I added standalone SMBus methods
> on I2cClient (smbus_read_byte_data, etc). Igor reviewed it [1] and
> pointed out that the agreed direction is for I2cClient to implement
> the generic Io trait [2] from Zhi Wang's driver-core-testing work.
> That discussion happened during Igor's own i2c-adapter series. I
> offered to take it on, and he confirmed bundling it in my series was
> fine.
> 
> I take your point about losing the SMBus naming clarity. The underlying
> calls are still `i2c_smbus_read_byte_data` and friends though, the Io
> trait just provides a uniform interface on top with bounds checking via
> `io_addr()`. The call sites in the driver use `try_read8`/`try_read16`
> which map 1:1 to the smbus byte/word operations.

The reason we need Wolfram and I2C folk in the discussion here is
the 'richness' of how the I2C spec is used.

I'll go a little further.  If this was renamed to make it the rust smbus
binding them I wouldn't be as bothered by this. For something claiming to
be I2C this is a misleading interface and I am very much against it.
Doing this is a path to a lot of confusion and problems for extensibility.

Maybe less than 50% of I2C devices use smbus calls (or at least in IIO,
it might be more standard elsewhere). That is partly because almost no
one uses that naming on datasheets so not everyone notices that they
can use them - this is also the reason the byte swapped variant is very
common - if you look at the I2C spec and implement auto increment on
addressing, then the byte order is a random choice.  A substantial
set of devices use a register style interface but due to subtle
protocol differences cannot use smbus.

Also perhaps relevant to this: If you'd submitted the driver in this
series as a c driver, you would have been asked the question: "why aren't
you using regmap".  It brings a rich set of helpers, standarized caching
etc.  The answer that applies here of the regmap binding isn't ready
isn't a great way to answer that question!

> 
> For other I2C access types (block, raw msg, etc), those would need
> additional trait methods or a separate abstraction.

Just sticking to byte and word reads, see the c. 7 different options in
regmap.  Given this is the I2C binding (not Smbus) one you've picked one
random choice from that set.  Also note there are other custom i2c regmap
implementations in drivers to cover the long tail of 'other' ways of doing
register access.

> Rust regmap bindings
> don't exist yet, so this is the available path for now. Once regmap
> lands in Rust, drivers that fit the regmap model can use that instead.

Understood that there is more to do, but given the regmap already encapsulates
the smbus support you have here, I'd be much more in favour of the focus
going on getting that done.  We will need i2c bindings as well but that
will be for the many devices that aren't register based etc for which this
trait approach is wrong.  I would almost suggest not merging a non regmap
interface for what you cover here, except we do get annoying corner cases
where the device uses a mixture of smbus like commands and non smbus so there
probably will need to be support at the i2c / smbus level.

> 
> [1] https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620
> 
> > One other comment inline. I'm seeing what looks to be a check for an
> > 8 bit address whereas smbus is 7 bit addressing.  
> 
> > Except smbus standard addressing is 7 bit.
> > Need space for the read / write bit.  
> 
> To clarify, `maxsize=256` here refers to the SMBus command byte
> (register address)
> range, not the device address. The command byte is a full 8 bits
> (0x00..0xFF = 256 values). 

I understood that - but to me it seems to be irrelevant.

> The 7-bit device address plus R/W bit is
> handled at the adapter level by the I2C core when the client is
> instantiated; it's not part of the register access path that Io wraps.

Agreed.

> 
> The `io_addr()` bounds check ensures `offset + sizeof(access) <= 256`,
> i.e. the register address stays within the valid command byte range.
> I'll add a comment in the code clarifying this distinction since the
> naming is confusing without it.

I'm still lost. The address must <= 128 to fit in the available 7 bits.
Why would you let it be bigger than that? It's going in a 7 bit field
not the byte that contains that field.

Is this separating a safety argument from a bug check?  If so why
not just use the tighter one?


> 
> > Unrelated change.  
> 
> Dropping the trailing-period fix from this patch in v4.
> 
> Thanks,
> Coirul

