Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeJaAyc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Oct 2018 20:54:32 -0400
MIME-Version: 1.0
References: <20181004001432.21218-1-mka@chromium.org> <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus> <20181012171523.GQ22824@google.com>
 <20181018194010.GV22824@google.com> <20181021151701.7b9daa41@archlinux>
In-Reply-To: <20181021151701.7b9daa41@archlinux>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Oct 2018 11:00:16 -0500
Message-ID: <CAL_JsqJ1KAHg2QR+R7f5Vdx7Z41Y8T1wVarwocjoYiHwqk12pw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 21, 2018 at 9:17 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 18 Oct 2018 12:40:10 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
>
> > On Fri, Oct 12, 2018 at 10:15:23AM -0700, Matthias Kaehlcke wrote:
> > > On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> > > > On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > > > > The node has a reg property, therefore its name should include a unit
> > > > > address.
> > > > >
> > > > > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > > > > DT conventions.
> > > >
> > > > This is ADC channels? If so, then DT convention would really be
> > > > "adc@...".
> > >
> > > Is it really? A grep for 'adc@' in arch/${ARCH}/boot/dts yields
> > > mostly ADC controller not channel nodes.
> > >
> > > I'm totally fine with changing the name to 'adc@...' if that's the
> > > preference/convention, just want to reconfirm since the actual use is
> > > a bit ambiguous.
> >
> > Could we please reach a conclusion on this?
> >
> > Summarizing the options on the table so far are:
> >
> > 1. usb-id-nopull@VADC_LR_MUX10_USB_ID
> > 2. usb-id-nopull@57
> > 3. adc@VADC_LR_MUX10_USB_ID
> > 4. adc@57
> >
> > My personal preference goes to something <node name>@<define>
> > since the unit address doesn't just resolve to an ADC channel number
> > but also includes configuation information. A literal like '57'
> > conveys less information than the define, it's easier to introduce
> > errors and these errors are harder to spot.
>
> I agree that to my mind this is the most sensible option.

If you really want the defines, then fine. Of course, that only works
if the function is fixed. It won't work if the function is defined per
board.

Eventually, examples using defines will have to also include the
headers. I plan to make the examples build-able.

> > If 'adc@...' really was the convention (or should be) I'd be clearly
> > in favor of following it. As mentioned above, in practice the use of
> > the 'adc@...' node name seems to be more prevalent for ADC controllers
> > than channels, so I'm more inclined towards 'usb-id-nopull@...' or
> > similar.
> >
> > All that said, these are just my preferences for the reasons outlined
> > above, if DT maintainers really want it to be 'adc@57' or some
> > variation of that, I'm fine with that too. Please let me know and we
> > can move forward with this trivial series.
>
> Rob, what's your view on this?

I want node names that reflect the class of the node (not a specific
model) and consistency across bindings. What that looks like for
multi-channel ADCs is really up to you. There was another binding
recently which mapped sub-nodes to inputs rather than channels. Maybe
that's needed too if you have more inputs than simultaneous channels.

Also, if your goal is to just quiet dtc warnings, then I'd prefer you
not. They often point to bigger issues even if they can be fixed with
trivial changes. Of course, if not fixed someone else will come along
and try the trivial fix again.

Rob
