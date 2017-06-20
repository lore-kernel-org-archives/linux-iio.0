Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbdFTROs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 13:14:48 -0400
Date: Tue, 20 Jun 2017 18:14:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        pmeerw@pmeerw.net, william.markezana@meas-spec.com,
        ludovic.tancerel@maplehightech.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: Add bindings for
 TSYS01 temperature sensor
Message-ID: <20170620181442.1eaa41d7@kernel.org>
In-Reply-To: <20170618140508.spcufhqqfvgkzzxf@rob-hp-laptop>
References: <1497369193-32538-1-git-send-email-manivannan.sadhasivam@linaro.org>
        <20170618140508.spcufhqqfvgkzzxf@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 18 Jun 2017 09:05:08 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jun 13, 2017 at 09:23:13PM +0530, Manivannan Sadhasivam wrote:
> > Add device tree bindings for Measurement Specialties TSYS01 temperature sensor
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/iio/temperature/tsys01.txt    | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/tsys01.txt  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied.  Thanks

Jonathan
