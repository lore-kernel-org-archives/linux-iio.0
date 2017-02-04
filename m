Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58856 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdBDMUb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:20:31 -0500
Subject: Re: [PATCH v3 1/2] iio: distance: add dt binding for devantech-srf04
To: Rob Herring <robh@kernel.org>, Andreas Klinger <ak@it-klinger.de>
References: <20170131180306.GA12880@andreas>
 <20170201174436.6p5hdis2rvpqus6g@rob-hp-laptop>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, dledford@redhat.com,
        akpm@linux-foundation.org, shraddha.6596@gmail.com, w@1wt.eu,
        balbi@kernel.org, mtk.manpages@gmail.com, sjenning@redhat.com,
        ksenija.stanojevic@gmail.com, vilhelm.gray@gmail.com,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <72c7c9e3-5700-ebf1-6f7b-01908aa2e40b@kernel.org>
Date: Sat, 4 Feb 2017 12:20:28 +0000
MIME-Version: 1.0
In-Reply-To: <20170201174436.6p5hdis2rvpqus6g@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/17 17:44, Rob Herring wrote:
> On Tue, Jan 31, 2017 at 07:03:06PM +0100, Andreas Klinger wrote:
>> This patch adds dt binding for devantech ultrasonic ranger srf04.
>>
>> The vendor "devantech" was already added to the vendor list with
>>         "[PATCH v4 1/3] iio: distance: srf08: add trivial DT binding"
>>
>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Probably just missed the upcoming merge window I'm afraid so will be 4.12 material now.

Jonathan
>> ---
>>  .../bindings/iio/proximity/devantech-srf04.txt     | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

