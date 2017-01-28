Return-Path: <SRS0=XE3H=ZK=gmail.com=manivannanece23@kernel.org>
Date: Sat, 28 Jan 2017 17:34:47 +0530
In-Reply-To: <4176fa77-a935-72ce-a61f-f91f4c24ed63@kernel.org>
References: <20170123162809.GA16800@gmail.com> <20170127203050.ah52xd5hpxyo6ojq@rob-hp-laptop> <4176fa77-a935-72ce-a61f-f91f4c24ed63@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] Documentation: dt-bindings: tmp007: Add optional interrupt support
To: Jonathan Cameron <jic23@kernel.org>,Rob Herring <robh@kernel.org>
CC: pmeerw@pmeerw.net,devicetree@vger.kernel.org,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Mani Sadhasivam <manivannanece23@gmail.com>
Message-ID: <7DDC483A-FA66-4D8D-A70B-F452C2E233C4@gmail.com>
List-ID: <linux-iio@vger.kernel.org>



On January 28, 2017 5:23:22 PM GMT+05:30, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On 27/01/17 20:30, Rob Herring wrote:
>> On Mon, Jan 23, 2017 at 09:58:09PM +0530, Manivannan Sadhasivam
>wrote:
>>> This patch adds optional interrupt binding support for TI TMP007 -
>IR thermopiler sensor
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail=2Ecom>
>>> ---
>>>
>>> Created separate patch for devicetree and driver=2E
>>>
>>>  Documentation/devicetree/bindings/iio/temperature/tmp007=2Etxt | 8
>++++++++
>>>  1 file changed, 8 insertions(+)
>>=20
>> Acked-by: Rob Herring <robh@kernel=2Eorg>
>>=20
>Applied to the togreg branch of iio=2Egit - shortly to be pushed out as
>testing
>for the autobuilders to play with it=2E
>
>Please cc linux-iio@vger=2Ekernel=2Eorg even when you are only touching t=
he
>bindings=2E
>Makes it less likely a patch will fall through the cracks!
Noted=2E  Thanks Jonathan=2E=20

-Mani
>
>Jonathan

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
