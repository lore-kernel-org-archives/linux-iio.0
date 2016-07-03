Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57583 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbcGCKyV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:54:21 -0400
Subject: Re: [PATCH v3 2/4] iio: potentiometer: mcp4531: Add device tree
 binding documentation
To: Rob Herring <robh@kernel.org>,
	Florian Vaussard <florian.vaussard@gmail.com>
References: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1467272091-28087-3-git-send-email-florian.vaussard@heig-vd.ch>
 <20160701021957.GA17269@rob-hp-laptop>
Cc: devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7e97bd0c-9af4-f27a-bece-a47d117f1910@kernel.org>
Date: Sun, 3 Jul 2016 11:54:19 +0100
MIME-Version: 1.0
In-Reply-To: <20160701021957.GA17269@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/07/16 03:19, Rob Herring wrote:
> On Thu, Jun 30, 2016 at 09:34:49AM +0200, Florian Vaussard wrote:
>> Add the device tree documentation for all the supported parts. Apart the
>> compatible string and standard I2C binding, no other binding is currently
>> needed.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>> ---
>>  .../devicetree/bindings/i2c/trivial-devices.txt    | 64 ++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied. Thanks

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

