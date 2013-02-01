Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	Denis Ciocca <denis.ciocca@gmail.com>
Date: Fri, 1 Feb 2013 13:35:22 +0100
Subject: Re: [RFC] Driver for lis331dlh
Message-ID: <1844577.EAlljCMzkH@elitebook-8460p>
References: <1359719147-30231-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <510BAEE6.2060600@metafoo.de> <510BAFF4.5070605@jic23.retrosnub.co.uk>
In-Reply-To: <510BAFF4.5070605@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi all,

On 01/02/13 11:45, Manuel Stahl wrote:
> This patch adds support for the ST microsystems lis331dlh. The lis331dlh =
is=20
a three-axis accelerometer with 16-bit ADC. It has an I2C and SPI interface=
.

STMicroelectronics :D

the support for lis331dlh is already available in accel driver as Lars and=
=20
Jonathan says.

> Guess the answer to my question is nothing at all needs adding then.
> Sorry, didn't think to check if it was already there.
> Denis is looking into supporting the lis3l02dq so we can kill that
> driver off and just have to handle the driver in misc.  For that
> we need to have a detailed discussion on their interfaces and how
> we maintain them going forward (what fun).

I have not started to look it. But I think it is possible to integrate all=
=20
sensors in the same driver.

Jonathan, Lars, what about last patch for code reduction in the library? I=
=20
think it's possible merge it in the library commit...
http://www.spinics.net/lists/linux-iio/msg07648.html


Thanks,

Denis=
