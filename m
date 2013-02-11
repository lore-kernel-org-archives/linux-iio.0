Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@gmail.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 11 Feb 2013 10:37:41 +0100
Subject: Re: Proposal to add full scale attribute
Message-ID: <5118BBE5.6070801@st.com>
References: <1360431297-18251-1-git-send-email-denis.ciocca@st.com>
 <5116BA7C.8020201@kernel.org>
In-Reply-To: <5116BA7C.8020201@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,


> What you propose has come up a number of times before (and
> is present I think as 'range' in a number of drivers still in staging)

I saw in the light/isl29018 driver what have you tell me, is exactly=20
what I would add.
To maintain the consistency, these values should be expressed in=20
framework units [m/s^2, ...]



> We did have a brief discussion a while ago about how to handle describing
> the possible range of channels and off controls on channels.
> One thing I suggested at the time (but have done nothing about since)
> was that we should actually have descriptions of the possible values
> of all elements of iio_info (including raw channel readings).
> The discussion was deep in a thread on something else so I won't
> try and dig it out now.
>
> Up shot was something like
>
> 1) have an additional callback in struct iio_info along the lines of:
> 	int (*read_avail)(struct iio_dev *indio_dev,
> 		          struct iio_chan_spec const *chan,
> 			  int **vals,
> 			  long mask);
> (return type indicates what vals is filled with).  Typically it'll be
> returning a pointer to a static array to avoid leaking memory.  Otherwise
> some care will be needed in drivers.

Very interesting...



> 2) For all iio_info elements there will be additional attributes to effec=
tively
> access pretty printed versions of the output of this callback.
>
> in_accel_raw_availble
> in_accel_scale_available
> ...
> (or similar).
>
> These would be read only and describe the possible values the associated
> output (e.g. in_accel_raw) can take.
>
> To make up some syntax how about
> [0...255] or {0, 13, 33} to indicate a range, or a small set of possible
> values?

In this case I'd like to find in_accel_range_available with this output:
{9.8 19.6 39.2 78.4}

Attribute scale is only one value to convert the current raw data to the=20
default frameworks units.

Now that I think, I don't know if is useful the raw_available and=20
scale_available...



> The in_accel_raw_available in conjunction with in_accel_scale would then
> effectively give your full range but also a lot of other useful informati=
on.
> As I stated earlier, we have had a range attribute proposed in the past
> (and is in some staging drivers) which is I think similar to your propose=
d
> full scale attribute.
> The issue I always had with it is that we then end up with the question o=
f
> which should be controllable, scale or range?  Scale is important for
> processing the data, but people like to see full scale as well.

Ok you have right, the scale attribute is more important to processing=20
the data, but what about resolution of the sensors?
The output data are fixed to a fixed number of bits in the all possible=20
full scale available for the sensor, this implies that the resolution of=20
the ADCs is different in function of the full scale selected.

If I know that the maximum interesting values are less than 9.8 m/s^2=20
how can I maximize the resolution?
If my only data is 'scale', I have to examine the datasheet and=20
understand which value of full scale is.



> You touch on efficiency of writing full scale in the patch. I am afraid
> I don't follow what you mean by that. Could you explain?  Setting these
> values is never in the fast path and in the vast majority of cases the
> conversion from one to the other is trivial.
>
> What do you think?

When I speak about efficiency I mean what I say before, increase the=20
resolution of the output data without consult the datasheet and do=20
reverse operations...


> Thanks for pointing out that we were out of space in the mask. I've been
> meaning to do something about that for a while.  One obvious option is
> to split the shared and separate masks up into a pair with the fields jus=
t
> defined in the appropriate one. Any other simple options occur to anyone?

No, I thought the same thing... :D



Denis=
