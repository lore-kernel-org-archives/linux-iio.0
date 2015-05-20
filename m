Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-055.synserver.de ([212.40.185.55]:1085 "EHLO
	smtp-out-055.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbETHrH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2015 03:47:07 -0400
Message-ID: <555C3BF4.8060906@metafoo.de>
Date: Wed, 20 May 2015 09:47:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: Add I/Q modifiers
References: <1432052790-26458-1-git-send-email-lars@metafoo.de> <CAEnQRZBW7aCmqasFsm5cFwv37BdwVb0W5LXOU7fhEHNbJqj1VA@mail.gmail.com>
In-Reply-To: <CAEnQRZBW7aCmqasFsm5cFwv37BdwVb0W5LXOU7fhEHNbJqj1VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/20/2015 07:57 AM, Daniel Baluta wrote:
> On Tue, May 19, 2015 at 7:26 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> I/Q modifiers can be used to denote signals which are represented by a
>> in-phase and a quadrature component.
>>
>> The ABI documentation describes the I and Q modifiers for current and
>> voltage channels for now as those will be the most likely users.
>>
>
> Hi Lars,
>
> Is there a driver exposing this ABI?

There is a driver. It is not yet upstream though.

- Lars
