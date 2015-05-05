Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdZu9SF8XdQnCkHDMNX-J=nB9hdE1SBEspoStDzpCDyOPA@mail.gmail.com>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
	<1430399755-26475-6-git-send-email-linus.walleij@linaro.org>
	<alpine.DEB.2.02.1504301637070.4190@pmeerw.net>
	<CACRpkdacUZfKkQz0XfXm4cqU+8B5TR8ZqJhXVzCTMcU+1EB2mA@mail.gmail.com>
	<5547A0D5.3000006@kernel.org>
	<CACRpkdZu9SF8XdQnCkHDMNX-J=nB9hdE1SBEspoStDzpCDyOPA@mail.gmail.com>
Date: Tue, 5 May 2015 14:41:41 +0200
Message-ID: <CACRpkdaU8SeKe_dSf1f4HEhZtN=M+gR3JN5pMeq6Ovp=E2b2iw@mail.gmail.com>
Subject: Re: [PATCH 06/10] iio: st_accel: support 8bit channel data
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, busybox@busybox.net,
	Denys Vlasenko <vda.linux@googlemail.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Looping in busybox people.

On Tue, May 5, 2015 at 2:22 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 4, 2015 at 6:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>> The generic_buffer.c
>> test app (now under tools/iio) should do the job for testing
>> this. The purpose of that one is to act as an example
>> of the chardev (buffered) interface and as documentation
>> as the docs always got out of date when we kept them seperately.
>> (yeah I'm lazy).
>
> Aha and that test app like iio_event_monitor needs proper
> device creation in /dev/iio:device0 etc ...
>
> And then I notice that busybox' mdev doesn't really auto-create
> devices for anything else than what appears below
> /sys/class/*, /sys/bus/* is not scanned for device, yippie-ay.
>
> I wonder how people solve this for IIO on stripped-down
> systems, static devices?
>
> Is mdev even doing the right thing by just looking under
> /sys/class?

Typically the following patch to mdev.c makes the devices
appear:

                recursive_action("/sys/class",
                        ACTION_RECURSE | ACTION_FOLLOWLINKS,
                        fileAction, dirAction, temp, 0);
+               recursive_action("/sys/bus/iio",
+                       ACTION_RECURSE | ACTION_FOLLOWLINKS,
+                       fileAction, dirAction, temp, 0);

That is not just a little bit annoying. Who is doing the wrong thing?

* Busybox does the wrong thing by just inspecting
  /sys/class for coldplug mdev -s

* IIO does the wrong thing by not registering a class
  device (I think Greg said he doesn't like these...)

Yours,
Linus Walleij
