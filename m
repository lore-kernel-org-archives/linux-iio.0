Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38944 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbH0FmO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 01:42:14 -0400
In-Reply-To: <CAKzfze8Qt99iUDyamy9bhxGHN3tJpMPVi6yMwe7zUfeF2YFO7Q@mail.gmail.com>
References: <CAKzfze8Qt99iUDyamy9bhxGHN3tJpMPVi6yMwe7zUfeF2YFO7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] Air quality sensor channel type
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 27 Aug 2015 06:41:48 +0100
To: Matt Ranostay <mranostay@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <A4AD71F9-277A-4483-A656-CFBC482F0AF6@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 27 August 2015 05:55:39 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>Jonathan et all,
>
>Shortly going to be working an i2c air quality sensor and noticed
>there is no current IIO_* channel attribute for anything VOC (volatile
>organic compound) or CO2 readings. The data that this sensor would
>report back is the parts per million of particles, so my first thought
>is something like IIO_VOCPPM.
Sounds sensible. Maybe throw together ABI docs in advance of driver.

>
>Also which subdirectory would make sense in? Or a new one like
>drivers/iio/voc ?

New directory. Are there other forms of air quality sensor? Perhaps even
 something general like IIO/chemical?



>
>MICS-VZ-89T I2C Datasheet:
>* http://sgx.cdistore.com/datasheets/sgx/VZ-89-I2C-Specs.pdf
>
>
>Thoughts? Comments?
>
>Thanks,
>
>Matt

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
