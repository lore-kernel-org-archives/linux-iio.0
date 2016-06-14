Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32968 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbcFNIWu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2016 04:22:50 -0400
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBZcQZRYGbk-6Eh5sN7_D90HTZPPo=uOSSZF2obB5VD+w@mail.gmail.com>
References: <20160613220843.GA4235@d830.WORKGROUP> <CAEnQRZBZcQZRYGbk-6Eh5sN7_D90HTZPPo=uOSSZF2obB5VD+w@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Tue, 14 Jun 2016 11:22:47 +0300
Message-ID: <CAEnQRZC9ES6dGyUdycW=nRuA=6yRa=i01BWBLt7uFsieE-74OQ@mail.gmail.com>
Subject: Re: MCP9808 iio or hwmon
To: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[fixing IIO, hwmon lists emails]

On Tue, Jun 14, 2016 at 11:20 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> On Tue, Jun 14, 2016 at 1:08 AM, Alison Schofield <amsfield22@gmail.com> wrote:
>>
>> I was working on an iio driver for MCP9808 when Jonathan took notice
>> and suggested we have the iio or hwmon discussion.
>>
>> So, where should this sensor driver reside?
>>
>> http://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
>>
>> It's a digital temp sensor with user programmable registers for
>> sensing applications.  Supports shutdown, low power modes,
>> specifying of event & critical output boundaries.  Can support
>> 8 sensors on a single serial bus. Touted as 'ideal for sophisticated
>> multi-zone temperature-monitoring applications.'
>
> This is debatable, looking to the datasheet this driver could reside
> in both places.
>
> Because this sensor has Industrial utility (e.g freezers, refrigerators) I
> am inclined to say we should support it in IIO.
>
> Any other opinions?
>
> thanks,
> Daniel.
