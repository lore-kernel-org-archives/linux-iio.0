Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/3] staging:iio: allow channels to be set up using a table of iio_channel_spec structures.
Date: Fri, 25 Mar 2011 16:26:36 +0100
Cc: linux-iio@vger.kernel.org
References: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk> <201103251537.02030.arnd@arndb.de> <4D8CB186.5030101@cam.ac.uk>
In-Reply-To: <4D8CB186.5030101@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103251626.36765.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Friday 25 March 2011, Jonathan Cameron wrote:
> > Better make it "unsigned long" instead of int when it's driver specific.
> > That way, a driver can store a pointer here if necessary.
> Makes sense. Perhaps a union to make the option explicit would be even
> better?

You can try it, but often unions cause more trouble than they are
worth. If most drivers just need an integer, using unsigned long
should be easier than a union.

> Whilst we are talking about types, some of the masks should probably switch to
> fixed length arrays of longs though so we don't have massive changes the
> moment we run out of space in the single longs.  All access will have to then
> be through the bitmap functions, but that should be fine.

Depends on whether you expect the masks to be exceeded any time soon.
I would expect 32 bits to be quite a lot, and it's easy to extend to
64 before you need to move to the bitops API.

> >> @@ -116,6 +248,31 @@ struct iio_dev {
> >>      u32                             *available_scan_masks;
> >>      struct iio_trigger              *trig;
> >>      struct iio_poll_func            *pollfunc;
> >> +
> >> +    struct iio_chan_spec *channels;
> >> +    int num_channels;
> >> +    struct list_head channel_attr_list;
> >> +
> >> +    char *name; /*device name - IMPLEMENT */
> >> +    int (*read_raw)(struct iio_dev *indio_dev, 
> >> +                    struct iio_chan_spec *chan,
> >> +                    int *val,
> >> +                    long mask);
> >> +
> >> +    int (*read_event_config)(struct iio_dev *indio_dev,
> >> +                             int event_code);
> >> +
> >> +    int (*write_event_config)(struct iio_dev *indio_dev,
> >> +                              int event_code,
> >> +                              struct iio_event_handler_list *listel,
> >> +                              int state);
> >> +
> >> +    int (*read_event_value)(struct iio_dev *indio_dev,
> >> +                            int event_code,
> >> +                            int *val);
> >> +    int (*write_event_value)(struct iio_dev *indio_dev,
> >> +                             int event_code,
> >> +                             int val);
> >>  };
> > 
> > As mentioned in the comment for 2/3, a number of the members here are
> > constant, so you could split the structure into a per-driver constant
> > part and a per-device part, like most other subsystems do.
>
> Good idea. Might have to be at a finer level than per driver though.
> I can certainly envision some drivers want for example to have a number
> of variants of read_raw to account for subtle difference in what channels
> are present on individual parts.

Right.

> However I think this refactoring should wait until after the other
> big changes are in. 

Ok.

	Arnd
