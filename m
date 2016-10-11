Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54037 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbcJKSjB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:39:01 -0400
Subject: Re: [PATCH 1/4] dt: bindings: i2c/trivial-devices.txt: Add 2 iio
 supported accelerometers
To: Rob Herring <robh@kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-2-hdegoede@redhat.com>
 <20161010214011.GA14377@rob-hp-laptop>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <70380e7c-d456-c676-5001-cfe3a77598ca@kernel.org>
Date: Tue, 11 Oct 2016 19:38:56 +0100
MIME-Version: 1.0
In-Reply-To: <20161010214011.GA14377@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 22:40, Rob Herring wrote:
> On Sat, Oct 08, 2016 at 02:34:23PM +0200, Hans de Goede wrote:
>> Add compatible strings for 2 accelerometers which follow the trivial
>> i2c device bindings and have been supported by the iio subsystem for
>> a while now.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Jonathan's already applied it, but FWIW:
But not to a non rebasing tree yet :)
> 
> Acked-by: Rob Herring <robh@kernel.org>
Added.  Thanks Rob!

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

