Return-Path: <SRS0=A2TP=KC=lechnology.com=david@kernel.org>
Subject: Re: [PATCH 2/4] spi: add new SPI_CS_WORD flag
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-3-david@lechnology.com>
 <20180718150450.GO5700@sirena.org.uk>
From: David Lechner <david@lechnology.com>
Message-ID: <a183973d-e648-c7e6-d65b-1479f7e32bb5@lechnology.com>
Date: Wed, 18 Jul 2018 11:47:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180718150450.GO5700@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 7/18/18 10:04 AM, Mark Brown wrote:
> On Mon, Jul 16, 2018 at 10:20:50PM -0500, David Lechner wrote:
>> This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
>> that a SPI device requires the chip select to be toggled after each
>> word that is transferred.
> 
> This feels like it should have a soft implementation if it is going to
> be truly usable, the vast majority of SPI controllers don't do this and

This occurred to me as well. Another possibility, though, would be to 
leave it up to the client device drivers to support both cases, e.g.:

	if (master has SPI_CS_WORD support)
		setup message as single transfer
	else
		setup message as multiple one-word transfers

This seems like that would be more efficient than having a generic 
implementation for masters that says:

	if (master does not have SPI_CS_WORD support)
		allocate enough transfers for each word of each
			each transfer of the message
		allocate and setup a new message for these transfers
		loop through the original transfers of the original
			message and copy them to the new transfers
		send the new message
		free allocated message and transfers

> I can only think of a few that have the hardware feature.  I'd also
> expect to see some validation added to the core spi_setup() since at
> present a client driver could set the mode option but then have it
> ignored by the controller which would presumably break things, we
> currently only have checks for specific modes and nothing that'd catch
> an unknown flag like this.

There is already a generic mode flags check in spi_setup() that will 
catch this and return an error if the device has the SPI_CS_WORD flag 
set and the controller does not. (I know this works because I ran into 
it during development.)

> 
> Ideally we'd also have some ability to use this as an optimization where
> possible with longer sequences (I can see a regmap cache sync being able
> to take advantage of this for example) but that might be more trouble
> than it's worth.
> 
