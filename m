Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45107 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdA1Lyk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 06:54:40 -0500
Subject: Re: [PATCH] Documentation: dt-bindings: tmp007: Add optional
 interrupt support
To: Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>
References: <20170123162809.GA16800@gmail.com>
 <20170127203050.ah52xd5hpxyo6ojq@rob-hp-laptop>
Cc: pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4176fa77-a935-72ce-a61f-f91f4c24ed63@kernel.org>
Date: Sat, 28 Jan 2017 11:53:22 +0000
MIME-Version: 1.0
In-Reply-To: <20170127203050.ah52xd5hpxyo6ojq@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/17 20:30, Rob Herring wrote:
> On Mon, Jan 23, 2017 at 09:58:09PM +0530, Manivannan Sadhasivam wrote:
>> This patch adds optional interrupt binding support for TI TMP007 - IR thermopiler sensor
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
>> ---
>>
>> Created separate patch for devicetree and driver.
>>
>>  Documentation/devicetree/bindings/iio/temperature/tmp007.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Applied to the togreg branch of iio.git - shortly to be pushed out as testing
for the autobuilders to play with it.

Please cc linux-iio@vger.kernel.org even when you are only touching the bindings.
Makes it less likely a patch will fall through the cracks!

Jonathan
