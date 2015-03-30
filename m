Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36711 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbC3E4d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 00:56:33 -0400
Received: by qcgx3 with SMTP id x3so4498173qcg.3
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2015 21:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150329040053.GD36501@dtor-ws>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
	<20150329040053.GD36501@dtor-ws>
Date: Sun, 29 Mar 2015 21:56:32 -0700
Message-ID: <CAL1qeaFHhPW=eS+CaVC1DZXHL8YausOaR1itc8pwVLTeWyDnMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
From: Andrew Bresticker <abrestic@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 28, 2015 at 9:00 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Mar 27, 2015 at 05:43:17PM -0700, Andrew Bresticker wrote:
>> Add a binding document for a generic ADC keypad.  Buttons on an ADC
>> keypad are connected in a resistor ladder to an ADC.  The binding
>> describes the mapping of ADC channel and voltage ranges to buttons.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> ---
>>  .../devicetree/bindings/input/adc-keys.txt         | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
>> new file mode 100644
>> index 0000000..c9a57de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
>> @@ -0,0 +1,43 @@
>> +Generic ADC keypad
>> +==================
>> +
>> +Required properties:
>> + - compatible: "adc-keys"
>> + - poll-interval: Polling interval time in ms.
>> + - io-channels: List of IIO channels used by the keypad.
>> +   See ../iio/iio-bindings.txt for details.
>> +
>> +Optional properties:
>> + - autorepeat: Enable auto-repeat.
>> +
>> +Each button on the ADC keypad is represented by a sub-node.
>> +
>> +Required sub-node properties:
>> + - label: Descriptive name for the key.
>> + - linux,code: Keycode to emit.
>> + - channel: IIO channel (index into the 'io-channels' above) to which this
>> +   button is attached.
>> + - min-voltage: Minimum voltage in uV when this key is pressed.
>> + - max-voltage: Maximum voltage in uV when this key is pressed.
>> +
>> +Optional sub-node properties:
>> + - linux,input-type: Event type this key generates.  Defaults to 1 (EV_KEY) if
>> +   not specified.
>
> I'd rather we have it defined explicitly in the binding, i.e. make it a
> required property?

Sure, will do.
