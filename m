Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42055 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJaGjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Oct 2018 02:39:54 -0400
Date: Tue, 30 Oct 2018 16:44:41 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Kelly <martin@martingkelly.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: magn: add LSM9DS1 bindings
Message-ID: <20181030214441.GA25441@bogus>
References: <20181026023812.29720-1-martin@martingkelly.com>
 <20181026023812.29720-4-martin@martingkelly.com>
 <20181028185308.20edd4f3@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181028185308.20edd4f3@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 28, 2018 at 06:53:08PM +0000, Jonathan Cameron wrote:
> On Thu, 25 Oct 2018 19:38:12 -0700
> Martin Kelly <martin@martingkelly.com> wrote:
> 
> > From: Martin Kelly <martin@martingkelly.com>
> > 
> > Add DT binding documentation for the LSM9DS1 magnetometer driver.

Bindings are for h/w, not drivers.

> > 
> > Signed-off-by: Martin Kelly <martin@martingkelly.com>
> Given here isn't really an alternative way of doing this (or we
> haven't come up with one yet) in the sensors that are basically multiple
> chips in one package, I'll hope that Rob is happy with the new name
> and apply it.   As I'm only pushing out for build tests today I can
> revert or add his Reviewed-by as needed.

Given only the supplies seem to be shared and those can be handled 
correctly with ref counting, separate devices is fine. We do the same 
thing for BT/WiFi combo chips with separate host interfaces.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
