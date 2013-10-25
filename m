Return-Path: <galak@codeaurora.org>
Subject: Re: [PATCHv2] iio:light:tsl2563: Add DT support
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <20131025082344.GA6425@earth.universe>
Date: Fri, 25 Oct 2013 03:37:22 -0500
Cc: linux-iio@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>,
 Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Landley <rob@landley.net>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bill Pemberton <wfp5p@virginia.edu>,
 Sachin Kamat <sachin.kamat@linaro.org>,
 devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <915C1A7A-6128-4B8B-A594-F2CDDED201DC@codeaurora.org>
References: <1382565063-17083-1-git-send-email-sre@debian.org> <1382624835-10228-1-git-send-email-sre@debian.org> <35B50A0C-D1F9-4D87-86DD-951BF71F2903@codeaurora.org> <20131025082344.GA6425@earth.universe>
To: Sebastian Reichel <sre@debian.org>
List-ID: <linux-iio@vger.kernel.org>


On Oct 25, 2013, at 3:23 AM, Sebastian Reichel wrote:

> On Thu, Oct 24, 2013 at 10:32:36PM -0500, Kumar Gala wrote:
>> On Oct 24, 2013, at 9:27 AM, Sebastian Reichel wrote:
>>> Add Device Tree support for the TSL2563 driver
>>> and document the binding.
>>>=20
>>> Signed-off-by: Sebastian Reichel <sre@debian.org>
>>> ---
>>> .../devicetree/bindings/iio/light/tsl2563.txt         | 19 =
+++++++++++++++++++
>>> Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
>>> drivers/iio/light/tsl2563.c                           |  4 ++++
>>=20
>> For the Binding, assuming another patch to add amstoas to the vendor =
list
>=20
> I embedded the vendor list update into this patch.
> Should I split this into its own patch?
>=20
> -- Sebastian

Its fine, but do update the commit comment about that.

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, =
hosted by The Linux Foundation
