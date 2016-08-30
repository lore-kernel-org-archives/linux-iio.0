Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4284e190-84c2-07cc-1157-ef6d2fdd0e8c@gmail.com>
References: <4284e190-84c2-07cc-1157-ef6d2fdd0e8c@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 30 Aug 2016 00:41:18 -0700
Message-ID: <CAKzfze-T6UqYp05YiGvHzxkV1bupSov0y_-p+0AiOtkbJETiKQ@mail.gmail.com>
Subject: Re: iio channel sync
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 29, 2016 at 10:03 AM, Joshua Clayton
<stillcompiling@gmail.com> wrote:
> Jonathan,
>
> I have an out-of tree driver I am working on mainlining.
>
> The device is a sensor that gets phase and amplitude (x and y) data
>
> on multiple physical and/or time multiplexed channels.
>
> It also has up to 4 optical encoders to get physical location.
>
> The existing driver bundles x and y together with a snapshot
>
> of the encoder sums at that moment.
>
>
> This seems like a good fit for iio, but one item is bothering me.
>
> How is synchronization between streams usually handled with
>
> iio drivers? Timing can be important.

Wouldn't the trigger buffer framework be good enough for this?

>
> Joshua Clayton
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
