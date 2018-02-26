Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1519631043.4724.14.camel@analog.com>
References: <20180216120915.19277-1-alexandru.ardelean@analog.com>
 <20180224121747.6ff4b90b@archlinux> <1519631043.4724.14.camel@analog.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 26 Feb 2018 12:47:28 +0200
Message-ID: <CAEnQRZAL17PCfdK0nUx35e5DUznt_g7CGb5fNv=v_HXtFq9APg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad5933: merge ring init function into probe function
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 26, 2018 at 9:44 AM, Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
> On Sat, 2018-02-24 at 12:18 +0000, Jonathan Cameron wrote:
>> On Fri, 16 Feb 2018 14:09:15 +0200
>> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>>
>> > This is a small cleanup of the driver's init code.
>> > It does not fix anything.
>> >
>> > The `devm_iio_kfifo_allocate()` function is used instead of
>> > `iio_kfifo_allocate()`.  This removes the need for explicit deallocation of
>> > the driver's iio_buffer, which will now be handled via
>> > `iio_device_unregister()`.
>> >
>> > The `setup_ops` assignment has been moved into the `ad5933_probe()` call,
>> > since it's a one-liner.
>> >
>> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> > ---
>> >
>> > Note: this change is based on top of `fixes-togreg-post-rc1` branch which
>> > contains commit (7d2b8e6aaf9: staging: iio: ad5933: switch buffer mode to
>> > software)
>>
>> It will take a few weeks for that to get to my togreg branch so please
>> do remind me if it has and I seem to have forgotten this!
>>
>> Jonathan
>
> I'm a bit new to how things progress in the iio subtree.
> [Curious] Is there a recommended branch that is regularly updated with accepted
> patches ?
> Or which branches do I need to rebase when submitting other patches ?


Salut Alexandru,

You can use the togreg branch of iio tree.

thanks,
Daniel.
