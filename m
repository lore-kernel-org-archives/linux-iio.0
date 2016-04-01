Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:54773 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbcDAJXX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2016 05:23:23 -0400
Subject: Re: [PATCH 2/2] ti-adc081c: Initial triggered buffer support
To: Crt Mori <cmo@melexis.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <cover.1459444547.git.leonard.crestez@intel.com>
 <b0276dfaa9a6a8ac1777bf5d92753dab1fc493b1.1459444547.git.leonard.crestez@intel.com>
 <CAKv63uuo-q0W+J2=MWVSpxaHFG4JFvjsHHGx8cwLHq_ZWdD1Jw@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56FE3DFB.5050409@metafoo.de>
Date: Fri, 1 Apr 2016 11:23:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv63uuo-q0W+J2=MWVSpxaHFG4JFvjsHHGx8cwLHq_ZWdD1Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/2016 10:08 AM, Crt Mori wrote:
> On 31 March 2016 at 19:20, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
>> Using this requires software triggers like CONFIG_IIO_HRTIMER_TRIGGER.
> Then we are missing DEPENDS in Kconfig...

The device could be used with any generic trigger. The device driver
shouldn't make the choice here which one it requires and which one not.

- Lars

