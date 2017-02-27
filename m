Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36159 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdB0OcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 09:32:08 -0500
Date: Mon, 27 Feb 2017 08:29:48 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
Message-ID: <20170227142948.eejne6j42lkzsiyq@rob-hp-laptop>
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
 <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
 <c2b73482-ae01-34b5-3c16-b7e63893259e@kernel.org>
 <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 24, 2017 at 05:04:45PM +0100, Fabrice Gasnier wrote:
> On 02/19/2017 01:09 PM, Jonathan Cameron wrote:
> > On 15/02/17 16:55, Fabrice Gasnier wrote:
> > > Add documentation for 'st,adc-res' dt optional property.
> > > 
> > > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > I'm happy with this, but would like to leave time for a device tree review.
> > 
> > Ultimately we may well want to make this a generic property and call it something
> > like adc-resolution but perhaps we need to wait until we have a few more devices
> > supporting setting it via device tree to figure out what the best interface is.
> > It would exactly be a problem to support this as a deprecated binding at that
> > point.
> 
> Hi Jonathan,
> 
> I agree with you on this... It may be better to have generic property
> for this, especially if you see that it will come in the near future.
> May I suggest this prop to be less restrictive, e.g. like resolution-bits as
> is may also be worth for other device types, e.g. DAC as an example ?

Yes, please make this a commmon property.

Rob
