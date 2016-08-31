Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1472683980.5025.35.camel@linux.intel.com>
Subject: Re: screen rotation flipped in 4.8-rc
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@sciencehorizons.net"
	 <linux@sciencehorizons.net>, "linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"hadess@hadess.net"
	 <hadess@hadess.net>
Date: Wed, 31 Aug 2016 15:53:00 -0700
In-Reply-To: <CAKzfze9KYOSzZxGz6PVb3xLeUN_0vYYVee4Y9HUgrz9iocxDkQ@mail.gmail.com>
References: <1472596930.23886.13.camel@intel.com>
	 <CAKzfze_p_6AiF93rY8HCMtm3BpDDjPS91nRbG49exrg4DV7Qzg@mail.gmail.com>
	 <1472674733.5025.28.camel@intel.com>
	 <CAKzfze_8zz6pYbccc3tpV_3qzT4gDRjaAxC_p4f3E+b0=FU4Wg@mail.gmail.com>
	 <1472675395.5025.31.camel@intel.com>
	 <CAKzfze9KYOSzZxGz6PVb3xLeUN_0vYYVee4Y9HUgrz9iocxDkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2016-08-31 at 13:43 -0700, Matt Ranostay wrote:
> On Wed, Aug 31, 2016 at 1:29 PM, Pandruvada, Srinivas
> <srinivas.pandruvada@intel.com> wrote:
> > 
> > On Wed, 2016-08-31 at 13:24 -0700, Matt Ranostay wrote:
> > > 
> > > On Wed, Aug 31, 2016 at 1:18 PM, Pandruvada, Srinivas
> > > <srinivas.pandruvada@intel.com> wrote:
> > > > 
> > > > 
> > > > On Tue, 2016-08-30 at 17:41 -0700, Matt Ranostay wrote:
> > > > > 
> > > > > 
> > > > > On Tue, Aug 30, 2016 at 3:42 PM, Pandruvada, Srinivas
> > > > > <srinivas.pandruvada@intel.com> wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Hi All,
> > > > > > 
> > > > > > I observed that using iio-sensor-proxy.service, the auto
> > > > > > screen
> > > > > > rotation flipped on my laptop (Normal -> vertical,
> > > > > > vertical-
> > > > > > > 
> > > > > > > 
> > > > > > > normal)
> > > > > > using kernel v4.8.
> > > > > > 
> > > > > > Anyone else has seen this?
> > > > > > 
> > > > > > I did a bisect and found a commit, which I am not sure how
> > > > > > can
> > > > > > it
> > > > > > impact.
> > > > > Could you post the results of CONFIG_TEST_HASH enabled?
> > > > Attached dmesg.txt with the CONFIG_TEST_HASH=y.
> > > > 
> > > > I see
> > > > [    4.276138] test_hash: __hash_32() has no arch
> > > > implementation to
> > > > test.
> > > > [    4.276138] test_hash: hash_32() has no arch implementation
> > > > to
> > > > test.
> > > > [    4.276139] test_hash: hash_64() has no arch implementation
> > > > to
> > > > test.
> > > > [    4.276141] test_hash: 33152 tests passed.
> > > > 
> > > Ok have you tested with that patchset reverted? And if so does
> > > the
> > > regression disappear?
> > Yes, but not after adding CONFIG_TEST_HASH=y.
> > regression disappears.
> > 
> > > 
> > > I would highly doubt if it was a issue with that dcache patchsets
> > > it
> > > wouldn't be breaking a ton of things.
> > I also think that.
> Only thing I could suspect is a toolchain bug.. Have crazy idea for
> you to try below..
> 
> From the patchset notice the return doesn't cast the result to
> (unsigned int) as before. But __hash_32_generic is "static inline
> u32", and maybe the end_name_hash is returning the whole result as a
> 64-bit unsigned long rather than 32-bit unsigned int.
> 
> ....
> static inline unsigned long end_name_hash(unsigned long hash)
> {
> - return (unsigned int)hash;
> + return __hash_32((unsigned int)hash);
> }
> ....
> 
> Just a theory.. Could totally be wrong :).
> 
I casted to unsigned int, still result is same. I need to look at the
user space program and compare data it is reading.

Thanks,
Srinivas
> > 
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > Thanks,
> > > > Srinivas
> > > > > 
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Matt
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > commit 703b5faf22fbddf984a361e6555f3a03fdba63d9
> > > > > > Author: George Spelvin <linux@sciencehorizons.net>
> > > > > > Date:   Fri Jun 10 00:22:12 2016 -0400
> > > > > > 
> > > > > >     fs/dcache.c: Save one 32-bit multiply in dcache lookup
> > > > > > 
> > > > > >     Noe that we're mixing in the parent pointer earlier, we
> > > > > >     don't need to use hash_32() to mix its bits.  Instead,
> > > > > > we
> > > > > > can
> > > > > >     just take the msbits of the hash value directly.
> > > > > > 
> > > > > >     For those applications which use the
> > > > > > partial_name_hash(),
> > > > > >     move the multiply to end_name_hash.
> > > > > > 
> > > > > >     Signed-off-by: George Spelvin <linux@sciencehorizons.ne
> > > > > > t>
> > > > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundatio
> > > > > > n.or
> > > > > > g>
> > > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Srinivas
