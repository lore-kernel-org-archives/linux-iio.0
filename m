Return-Path: <SRS0=eyJT=DB=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Gregor Boirie <gregor.boirie@parrot.com>
Cc: Bartosz =?utf-8?Q?Go=C5=82aszewski?= <bartekgola@gmail.com>,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 "thierry.reding\@gmail.com" <thierry.reding@gmail.com>,
 linux-pwm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-gpio@vger.kernel.org
Subject: Re: [RFC] Periodic Output, Timestamped Input
In-Reply-To: <CACRpkdbSPqnOjnmCd6-0FZznw+ojzA87Qmv9n5qxAwFHnHLUOw@mail.gmail.com>
References: <87ineapo5w.fsf@linux.intel.com> <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com> <87shcxw5n3.fsf@linux.intel.com> <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com> <87609ltts4.fsf@linux.intel.com> <CACRpkdbSPqnOjnmCd6-0FZznw+ojzA87Qmv9n5qxAwFHnHLUOw@mail.gmail.com>
Date: Tue, 05 Dec 2017 13:23:56 +0200
Message-ID: <87vahls9ir.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Linus Walleij <linus.walleij@linaro.org> writes:
> On Tue, Dec 5, 2017 at 10:20 AM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>> [Me]:
>
>>> I was thinking about it already when implementing it but it fell
>>> out of my mind. I'm putting in on my TODO. (CC to bartosz
>>> who might be interested, he's using these ABIs quite a bit.)
>>
>> fair enough. In that case, it'll probably be easier to implement
>> HW-based timestamping with something like below:
>
> Indeed.
>
> IIO has a per-device sysfs file for setting up
> the POSIX timestamping named current_timestamp_clock.
> This was added by Gregor Boire in commit
> bc2b7dab629a
>
> The supported timestamps are:
> realtime
> monotonic
> monotonic_raw
> realtime_coarse
> monotonic_coarse
> boottime
> tai
>
> I could really need some help here... :/
>
> It feels like "monotonic" could very well be what you're
> looking for but I don't know the POSIX definition of these.
> Maybe we need to add one more for "device specific"?
>
> What I want to do is factor most of that commit out into
> lib/ and reuse for timestamping in GPIO so we can
> have coherent timestamps across GPIO and IIO.
>
> OK OK O need to get to it and stop talking...
>
> I guess it should be set per-gpiochip rather than
> per-gpio-desc though, but that makes most sense anyways.

Well, it may be that not every pin on a gpiochip supports HW-backed
timestamping. Just speculating here, that's why I made it per-gpio_desc
on the example.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlomgcwACgkQzL64meEa
mQYKhQ/9FjJv6PDQuTJsQu/2wxHcqIX1B7sFH3KSjPvT3Wc9BVJy12w4kxso6+aU
OTOEhDsFLR6EsljILb43dBCd8dkf5SwNi5tPP5VdPHeZ3OmwCbdKKvNVt3uGwEHc
Z7ztONyEDvy8lmEX9swvhVn3c5vTKEgjeCNo7Pemu5HceQOWxOP8/R1evAzdzCN5
UyJxVpb16W0HQJlnXCvonf/lFjSpFh8axvLKKRe3uM5i3DTgNRCHX9oFW1dQIM2g
YE67fLB3n7/jAdSdBXJfB2PcYdhnO1sVsv2yRQ57mLBRZir59e3/Ge5jE2Q92qoE
7FnHXflLuj3TGTEDPFii28+ymbgi8bqthzGIRbeRsBABmUv+42qN1MRjqui9ABUZ
ofpuYLi5mb671sp0b2DMR66t4YG42xh+WkpYE3KKY0OGJwnx7dx10BeBE3NZMvOk
VZFc8eJDuWMJAxO3gbJpTFffauPhF2IFgHOgGPDr6A79poqrxqbprir+UHyStJjG
otHq6k/Xu6oD6RbX2lbK4SB5C7l05vc6O/T+a3mX0jn9BmxxqnEKToIsg35OY0zF
0ILkqZ1U5DhK8U3VLdHgPlP9DWOpNqUExtMZl+O8DdKWAGMLl8InNabeQXTsrOWT
DsYFR4wgRScP7SRFLp5jNc1KaB+8z8QCdy2eJaa0ukSUweC3CPk=
=fg6t
-----END PGP SIGNATURE-----
--=-=-=--
