Return-Path: <vianney.leclement@essensium.com>
Date: Mon, 9 Mar 2015 20:52:50 +0100
From: Vianney le =?iso-8859-1?q?Cl=E9ment?= <vianney.leclement@essensium.com>
Subject: Re: [PATCH 5/7] iio: mlx90614: Allow tuning EEPROM configuration
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, "Arnout
 Vandecappelle (Essensium/Mind)" <arnout@mind.be>, Wolfram Sang
	<wsa@the-dreams.de>
Message-ID: <1425930770.5817.5@mail.essensium.com>
In-Reply-To: <54FDBF2A.6010402@kernel.org>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
	<1424879712-28304-6-git-send-email-vianney.leclement@essensium.com>
	<54FDBDCC.50204@kernel.org> <54FDBF2A.6010402@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 9, 2015 at 4:41 , Jonathan Cameron <jic23@kernel.org> wrote:
> 
>  Emissivity is well defined. I'd like this to be a standard attribute 
> with
> 
>  full documentation please rather than a driver specific one.  Happy
>  to have this added to the infomask elements if it make sense.

It does make sense.  This parameter cannot be set separately for the 
two IR sensors though (for the dual-sensor model).  Should the 
attribute still be shared by type, even though it does not apply to the 
ambient temperature?  Or should we add "shared by modifier" attributes 
(not sure it is worth it)?

> 
>  Hmm odd to have two different filter types with separate control.
> 
>  However we have _filter_low_pass_3db_frequency and whilst it is a 
> pain
> 
>  obviously to map this to that form that's the way to go from a useful
> 
>  userspace interface point of view.  If we need to extend the filter
> 
>  description interface (filter type has been suggested before) then 
> please
> 
>  propose that.
> 
> 
> 
>  Here I see they are suggesting one filter is effectively for 
> ignoreing
> 
>  fast passing objects, and the other for noise prevention.  They both
> 
>  effect the settling time.
> 
> 
> 
>  Anyhow it's not entirely obvious what the right answer is, but its
> 
>  definitely not a driver specific interface such as we have.
> 
> 
>  Peter, any thoughts?

I will look into this.  Any thoughts from Peter are indeed welcome.

>>  +	&iio_dev_attr_gain.dev_attr.attr,
> 
>  Please use the standard IIO infomask elements for scale (or perhaps
>  calibscale - I haven't checked which is appropriate).

Ok.

Vianney
