Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:45133
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751313AbdA1XRO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Jan 2017 18:17:14 -0500
Subject: Re: [PATCH v8 07/12] dt-bindings: i2c: i2c-mux-simple: document
 i2c-mux-simple bindings
To: Rob Herring <robh@kernel.org>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-8-git-send-email-peda@axentia.se>
 <20170127193917.6xuunrkjkqh4f2v7@rob-hp-laptop>
CC: <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <835415bf-77af-6131-d018-d0bc7d8233b0@axentia.se>
Date: Sat, 28 Jan 2017 23:42:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170127193917.6xuunrkjkqh4f2v7@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-01-27 20:39, Rob Herring wrote:
> On Wed, Jan 18, 2017 at 04:57:10PM +0100, Peter Rosin wrote:
>> Describe how a generic multiplexer controller is used to mux an i2c bus.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 81 ++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
>> new file mode 100644
>> index 000000000000..253d5027843b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
>> @@ -0,0 +1,81 @@
>> +Simple I2C Bus Mux
>> +
>> +This binding describes an I2C bus multiplexer that uses a mux controller
>> +from the mux subsystem to route the I2C signals.
>> +
>> +                                  .-----.  .-----.
>> +                                  | dev |  | dev |
>> +    .------------.                '-----'  '-----'
>> +    | SoC        |                   |        |
>> +    |            |          .--------+--------'
>> +    |   .------. |  .------+    child bus A, on MUX value set to 0
>> +    |   | I2C  |-|--| Mux  |
>> +    |   '------' |  '--+---+    child bus B, on MUX value set to 1
>> +    |   .------. |     |    '----------+--------+--------.
>> +    |   | MUX- | |     |               |        |        |
>> +    |   | Ctrl |-|-----+            .-----.  .-----.  .-----.
>> +    |   '------' |                  | dev |  | dev |  | dev |
>> +    '------------'                  '-----'  '-----'  '-----'
>> +
>> +Required properties:
>> +- compatible: i2c-mux-simple,mux-locked or i2c-mux-simple,parent-locked
> 
> Not a fan of using "simple" nor the ','. Perhaps lock type should be 
> separate property.

How about just i2c-mux for the compatible? Because i2c-mux-mux (which
follows the naming of previous i2c muxes) looks really stupid. Or
perhaps i2c-mux-generic?

I'm also happy to have the lock type as a separate property. One lock
type, e.g. parent-locked, could be the default and adding a 'mux-locked'
property could change that. Would that be ok?

Or should it be a requirement that one of 'mux-locked'/'parent-locked'
is always present?

> I'm not sure I get the mux vs. parent locked fully. How do I determine 
> what type I have? We already have bindings for several types of i2c 
> muxes. How does the locking annotation fit into those?

We have briefly discussed this before [1] in the context of i2c-mux-gpio
and i2c-mux-pinctrl, when I added the mux-locked/parent-locked distinction
to the i2c-mux infrastructure (it wasn't named mux-locked/parent-locked
way back then though). There is more detail on what the difference is
between the two in Documentation/i2c/i2c-topology.

Side note regarding your remark "use an I2C controlled mux instead"; it
appears that I'm not alone [2] with this kind of requirement...

[1] https://lkml.org/lkml/2016/1/6/437
[2] http://marc.info/?t=147877959100002&r=1&w=2

But, now that I have pondered on this for a year or so, I firmly
believe it was a mistake to have the code in i2c-mux-gpio and
i2c-mux-pinctrl automatically try to deduce if the mux should be
mux-locked or parent-locked. It might be easy to make that call
in some trivial cases, but it is not difficult to dream up
scenarios where it would be extremely hard for the code to get
this decision right. It's just fragile. But now we have code in
those two muxes that has unwanted tentacles into the guts of the
gpio and pinctrl subsystems. Hopefully those unwanted tentacles
can be replaced with something based on device links? However, it
is still not hard to come up with scenarios that will require
manual intervention in order to select the right kind of i2c mux
locking. So, I fear that we have inadequate code trying to make a
decision automatically, and that we at some point down the line
will have some impossible case needing a binding that trumps the
heuristic. Why have a heuristic at all in that case? In short, it
should have been a binding from the start, methinks.

That was a long rant regarding i2c-mux-gpio and i2c-mux-pinctrl.
I obviously think it is bad to have this new i2c mux go in the
same direction as those two drivers. I.e. I think a binding that
specifies the desired locking is preferable to any attempted
heuristic.

Cheers,
peda

