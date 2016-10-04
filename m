Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161004134401.GA12103@rob-hp-laptop>
References: <20161002155135.23298-1-hdegoede@redhat.com> <20161002155135.23298-2-hdegoede@redhat.com>
 <20161004134401.GA12103@rob-hp-laptop>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Oct 2016 09:18:25 -0500
Message-ID: <CAL_JsqKZvrVCEhWW6WLT77xUsJz3-+HRYt4O9NJiEbBM3PRq1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt: bindings: vendor-prefix: Add 3 accelerometer
 vendor prefixes
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 4, 2016 at 8:44 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Oct 02, 2016 at 05:51:35PM +0200, Hans de Goede wrote:
>> Recently the kernel has gotten support in the iio subsystem for a number
>> of new accelerometers from Domintech, mCube, Memsic and MiraMEMS.
>>
>> This commit adds the vendor prefixes already used for these vendors
>> in Documentation/devicetree/bindings/i2c/trivial-devices.txt to
>> vendor-prefixes.txt.
>>
>> Domintech's full company name was taken from copyright headers for
>> their drivers from: https://github.com/domintech/
>>
>> The other full company names were taken from the company's websites:
>> http://www.mcubemems.com/
>> http://www.memsic.com/
>> http://www.miramems.com/en/
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> I've applied this one to avoid any conflicts with sorting
> vendor-prefixes.txt. I fixed up the sorting of mcube.

I've now dropped this because Domintech is already in Jonathan's tree.
Please respin.

Rob
