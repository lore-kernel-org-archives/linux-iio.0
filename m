Return-Path: <SRS0=iYD7=44=cogentembedded.com=vladimir.barinov@kernel.org>
Subject: Re: [PATCH 3/4] iio: hi8435: make in_voltage_sensing_mode_available
 visible
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-3-nikita.yoush@cogentembedded.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Message-ID: <672468dc-3e13-93ea-1671-ba1193c0d6e9@cogentembedded.com>
Date: Mon, 22 May 2017 21:21:05 +0300
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-3-nikita.yoush@cogentembedded.com>
Content-Type: multipart/alternative;
 boundary="------------F93104E76ADA2600E0299CD1"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------F93104E76ADA2600E0299CD1
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.2017 17:48, Nikita Yushchenko wrote:
> Possible values of sensing_mode are encoded with strings and actual
> atrings used are not obvious.
>
> Provide a hint by enabling in_voltage_sensing_mode_available attribute.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>   drivers/iio/adc/hi8435.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 45a92e3e8f2b..d09cb6ff8044 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -356,6 +356,7 @@ static const struct iio_enum hi8435_sensing_mode = {
>   
>   static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
>   	IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
> +	IIO_ENUM_AVAILABLE("sensing_mode", &hi8435_sensing_mode),
>   	{},
>   };
>   

Acked-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>



--------------F93104E76ADA2600E0299CD1
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 19.05.2017 17:48, Nikita Yushchenko
      wrote:<br>
    </div>
    <blockquote
      cite="mid:20170519144802.14427-3-nikita.yoush@cogentembedded.com"
      type="cite">
      <pre wrap="">Possible values of sensing_mode are encoded with strings and actual
atrings used are not obvious.

Provide a hint by enabling in_voltage_sensing_mode_available attribute.

Signed-off-by: Nikita Yushchenko <a class="moz-txt-link-rfc2396E" href="mailto:nikita.yoush@cogentembedded.com">&lt;nikita.yoush@cogentembedded.com&gt;</a>
---
 drivers/iio/adc/hi8435.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 45a92e3e8f2b..d09cb6ff8044 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -356,6 +356,7 @@ static const struct iio_enum hi8435_sensing_mode = {
 
 static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
 	IIO_ENUM("sensing_mode", IIO_SEPARATE, &amp;hi8435_sensing_mode),
+	IIO_ENUM_AVAILABLE("sensing_mode", &amp;hi8435_sensing_mode),
 	{},
 };
 
</pre>
    </blockquote>
    <p>Acked-by: Vladimir Barinov <a class="moz-txt-link-rfc2396E"
        href="mailto:vladimir.barinov@cogentembedded.com">&lt;vladimir.barinov@cogentembedded.com&gt;</a>
      <br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------F93104E76ADA2600E0299CD1--
