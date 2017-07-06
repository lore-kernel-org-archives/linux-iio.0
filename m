Return-Path: <SRS0=6miq=6J=gmail.com=jackoalan@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170706070913.qh2ztrvbvi7gy5co@dell>
References: <1499289168-14392-1-git-send-email-jackoalan@gmail.com>
 <1499289168-14392-3-git-send-email-jackoalan@gmail.com> <CAPHBK3bnoUNXHdOwswGRDkiwHZSh6K1fRdJaTHDzaQwL_kP=Bw@mail.gmail.com>
 <20170706070913.qh2ztrvbvi7gy5co@dell>
From: Jack Andersen <jackoalan@gmail.com>
Date: Thu, 6 Jul 2017 11:01:54 -1000
Message-ID: <CAPHBK3bruRbdXEO-+R_913LxiaOwNTR2-65T8WD+TAi23OcAFg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mfd: dln2: Send restart command if HW init fails
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: multipart/mixed; boundary="001a113cdd32391a450553ac6d89"
List-ID: <linux-iio@vger.kernel.org>

--001a113cdd32391a450553ac6d89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The restart command doesn't behave like other commands. It doesn't
return an error code (which indicates a failed transfer in the dln2
module so the probe fails). Attached is a system log snippet to give
you a better idea.

I'm able to consistently reproduce this behavior on 4.12 by
registering an ADC event on the DLN2 then restarting the host without
powering off. Without the dln2_restart patch, it ends on the `dln2:
probe of 1-2:1.0 failed with error -110' line. Shortly after issuing
the restart, the kernel indicates a device disconnect, and it
reconnects about 400ms later, with a usable device state.

On 5 July 2017 at 21:09, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 05 Jul 2017, Jack Andersen wrote:
>
>> I have mixed feelings about making this patch. The device appears to
>> lose its ability to send command responses when the driver
>> unexpectedly goes offline (probably overflowing an internal send
>> buffer).
>>
>> The restart command is a send-only way to recover the device.
>> What concerns me is if there's another issue causing init to fail and
>> a restart doesn't fix, this will trigger an endless probe loop. I'm
>> not sure if there's a better way to discern this condition.
>
> Why does dln2_restart() cause an unbind/bind?
>
>> On 5 July 2017 at 11:12, Jack Andersen <jackoalan@gmail.com> wrote:
>> > There's an issue with reinitializing DLN2 hardware if ADC channel even=
t
>> > configurations aren't reset before suspending the driver. A physical r=
econnect
>> > of the device solves the problem, but restarting the machine without a=
 power
>> > cycle leaves the device state inconsistent.
>> >
>> > This patch transmits a restart command in the event of a failed init.
>> > To the kernel's perspective, this is the rough equivalent of a disconn=
ect and
>> > reconnect, so another probe occurs shortly afterwards.
>> >
>> > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
>> > ---
>> >  drivers/mfd/dln2.c | 11 ++++++++++-
>> >  1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
>> > index a22ab8c..1eb0056 100644
>> > --- a/drivers/mfd/dln2.c
>> > +++ b/drivers/mfd/dln2.c
>> > @@ -40,6 +40,7 @@ struct dln2_response {
>> >  #define DLN2_GENERIC_CMD(cmd)          DLN2_CMD(cmd, DLN2_GENERIC_MOD=
ULE_ID)
>> >  #define CMD_GET_DEVICE_VER             DLN2_GENERIC_CMD(0x30)
>> >  #define CMD_GET_DEVICE_SN              DLN2_GENERIC_CMD(0x31)
>> > +#define CMD_RESTART                    DLN2_GENERIC_CMD(0x43)
>> >
>> >  #define DLN2_HW_ID                     0x200
>> >  #define DLN2_USB_TIMEOUT               200     /* in ms */
>> > @@ -531,6 +532,12 @@ int dln2_transfer(struct platform_device *pdev, u=
16 cmd,
>> >  }
>> >  EXPORT_SYMBOL(dln2_transfer);
>> >
>> > +static int dln2_restart(struct dln2_dev *dln2)
>> > +{
>> > +       return _dln2_transfer(dln2, DLN2_HANDLE_CTRL, CMD_RESTART,
>> > +                             NULL, 0, NULL, NULL);
>> > +}
>> > +
>> >  static int dln2_check_hw(struct dln2_dev *dln2)
>> >  {
>> >         int ret;
>> > @@ -782,7 +789,9 @@ static int dln2_probe(struct usb_interface *interf=
ace,
>> >
>> >         ret =3D dln2_hw_init(dln2);
>> >         if (ret < 0) {
>> > -               dev_err(dev, "failed to initialize hardware\n");
>> > +               dev_err(dev,
>> > +                       "failed to initialize hardware; attempting res=
tart\n");
>> > +               dln2_restart(dln2);
>> >                 goto out_stop_rx;
>> >         }
>> >
>> >
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--001a113cdd32391a450553ac6d89
Content-Type: text/plain; charset="US-ASCII"; name="dln2-log.txt"
Content-Disposition: attachment; filename="dln2-log.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j4swkn8i0

WyAgICAxLjMxNjI4NV0gdXNiIDEtMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPWEy
NTcsIGlkUHJvZHVjdD0yMDEzClsgICAgMS4zMTYyODZdIHVzYiAxLTI6IE5ldyBVU0IgZGV2aWNl
IHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0wClsgICAgMS4zMTYyODdd
IHVzYiAxLTI6IFByb2R1Y3Q6IERpb2xhbiBETE4yClsgICAgMS4zMTYyODhdIHVzYiAxLTI6IE1h
bnVmYWN0dXJlcjogRGlvbGFuClsgICAgMi4yNjQyNDhdIGRsbjI6IGxvYWRpbmcgb3V0LW9mLXRy
ZWUgbW9kdWxlIHRhaW50cyBrZXJuZWwuClsgICAgMi4yNjQyODJdIGRsbjI6IG1vZHVsZSB2ZXJp
ZmljYXRpb24gZmFpbGVkOiBzaWduYXR1cmUgYW5kL29yIHJlcXVpcmVkIGtleSBtaXNzaW5nIC0g
dGFpbnRpbmcga2VybmVsClsgICAgMi40Njk5NTFdIGRsbjIgMS0yOjEuMDogZmFpbGVkIHRvIGlu
aXRpYWxpemUgaGFyZHdhcmU7IGF0dGVtcHRpbmcgcmVzdGFydApbICAgIDIuNjAyNzI5XSBkbG4y
IDEtMjoxLjA6IG5vbnplcm8gdXJiIHN0YXR1cyByZWNlaXZlZCAtNzEKWyAgICAyLjYwMjc2MV0g
ZGxuMiAxLTI6MS4wOiBub256ZXJvIHVyYiBzdGF0dXMgcmVjZWl2ZWQgLTcxClsgICAgMi42MDI4
NDFdIGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIgc3RhdHVzIHJlY2VpdmVkIC03MQpbICAgIDIu
NjAyOTU3XSBkbG4yIDEtMjoxLjA6IG5vbnplcm8gdXJiIHN0YXR1cyByZWNlaXZlZCAtNzEKWyAg
ICAyLjYwMzAzOF0gZGxuMiAxLTI6MS4wOiBub256ZXJvIHVyYiBzdGF0dXMgcmVjZWl2ZWQgLTcx
ClsgICAgMi42MDMxMTddIGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIgc3RhdHVzIHJlY2VpdmVk
IC03MQpbICAgIDIuNjAzMjAxXSBkbG4yIDEtMjoxLjA6IG5vbnplcm8gdXJiIHN0YXR1cyByZWNl
aXZlZCAtNzEKWyAgICAyLjYwMzI3N10gZGxuMiAxLTI6MS4wOiBub256ZXJvIHVyYiBzdGF0dXMg
cmVjZWl2ZWQgLTcxClsgICAgMi42MDMzMjhdIGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIgc3Rh
dHVzIHJlY2VpdmVkIC03MQpbICAgIDIuNjAzMzQ1XSB1c2IgMS0yOiBVU0IgZGlzY29ubmVjdCwg
ZGV2aWNlIG51bWJlciAyClsgICAgMi42MDMzOThdIGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIg
c3RhdHVzIHJlY2VpdmVkIC03MQpbICAgIDIuNjAzMzk4XSBkbG4yIDEtMjoxLjA6IGZhaWxlZCB0
byByZXN1Ym1pdCBSWCBVUkI6IC0xOQpbICAgIDIuNjAzNDM3XSBkbG4yIDEtMjoxLjA6IG5vbnpl
cm8gdXJiIHN0YXR1cyByZWNlaXZlZCAtNzEKWyAgICAyLjYwMzQzOF0gZGxuMiAxLTI6MS4wOiBm
YWlsZWQgdG8gcmVzdWJtaXQgUlggVVJCOiAtMTkKWyAgICAyLjYwMzQ3N10gZGxuMiAxLTI6MS4w
OiBub256ZXJvIHVyYiBzdGF0dXMgcmVjZWl2ZWQgLTcxClsgICAgMi42MDM0NzhdIGRsbjIgMS0y
OjEuMDogZmFpbGVkIHRvIHJlc3VibWl0IFJYIFVSQjogLTE5ClsgICAgMi42MDM1MTddIGRsbjIg
MS0yOjEuMDogbm9uemVybyB1cmIgc3RhdHVzIHJlY2VpdmVkIC03MQpbICAgIDIuNjAzNTE4XSBk
bG4yIDEtMjoxLjA6IGZhaWxlZCB0byByZXN1Ym1pdCBSWCBVUkI6IC0xOQpbICAgIDIuNjAzNTYx
XSBkbG4yIDEtMjoxLjA6IG5vbnplcm8gdXJiIHN0YXR1cyByZWNlaXZlZCAtNzEKWyAgICAyLjYw
MzU2MV0gZGxuMiAxLTI6MS4wOiBmYWlsZWQgdG8gcmVzdWJtaXQgUlggVVJCOiAtMTkKWyAgICAy
LjYwMzU5N10gZGxuMiAxLTI6MS4wOiBub256ZXJvIHVyYiBzdGF0dXMgcmVjZWl2ZWQgLTcxClsg
ICAgMi42MDM1OThdIGRsbjIgMS0yOjEuMDogZmFpbGVkIHRvIHJlc3VibWl0IFJYIFVSQjogLTE5
ClsgICAgMi42MDM2MzddIGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIgc3RhdHVzIHJlY2VpdmVk
IC03MQpbICAgIDIuNjAzNjM4XSBkbG4yIDEtMjoxLjA6IGZhaWxlZCB0byByZXN1Ym1pdCBSWCBV
UkI6IC0xOQpbICAgIDIuNjAzNjc3XSBkbG4yIDEtMjoxLjA6IG5vbnplcm8gdXJiIHN0YXR1cyBy
ZWNlaXZlZCAtNzEKWyAgICAyLjYwMzY3OF0gZGxuMiAxLTI6MS4wOiBmYWlsZWQgdG8gcmVzdWJt
aXQgUlggVVJCOiAtMTkKWyAgICAyLjYwMzcxN10gZGxuMiAxLTI6MS4wOiBub256ZXJvIHVyYiBz
dGF0dXMgcmVjZWl2ZWQgLTcxClsgICAgMi42MDM3MThdIGRsbjIgMS0yOjEuMDogZmFpbGVkIHRv
IHJlc3VibWl0IFJYIFVSQjogLTE5ClsgICAgMi42MDM3NTddIGRsbjIgMS0yOjEuMDogbm9uemVy
byB1cmIgc3RhdHVzIHJlY2VpdmVkIC03MQpbICAgIDIuNjAzNzU4XSBkbG4yIDEtMjoxLjA6IGZh
aWxlZCB0byByZXN1Ym1pdCBSWCBVUkI6IC0xOQpbICAgIDIuNjAzNzk3XSBkbG4yIDEtMjoxLjA6
IG5vbnplcm8gdXJiIHN0YXR1cyByZWNlaXZlZCAtNzEKWyAgICAyLjYwMzc5OF0gZGxuMiAxLTI6
MS4wOiBmYWlsZWQgdG8gcmVzdWJtaXQgUlggVVJCOiAtMTkKWyAgICAyLjYwMzg0MV0gZGxuMiAx
LTI6MS4wOiBub256ZXJvIHVyYiBzdGF0dXMgcmVjZWl2ZWQgLTcxClsgICAgMi42MDM4NDJdIGRs
bjIgMS0yOjEuMDogZmFpbGVkIHRvIHJlc3VibWl0IFJYIFVSQjogLTE5ClsgICAgMi42MDM4ODBd
IGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIgc3RhdHVzIHJlY2VpdmVkIC03MQpbICAgIDIuNjAz
ODgxXSBkbG4yIDEtMjoxLjA6IGZhaWxlZCB0byByZXN1Ym1pdCBSWCBVUkI6IC0xOQpbICAgIDIu
NjAzOTE3XSBkbG4yIDEtMjoxLjA6IG5vbnplcm8gdXJiIHN0YXR1cyByZWNlaXZlZCAtNzEKWyAg
ICAyLjYwMzkxOF0gZGxuMiAxLTI6MS4wOiBmYWlsZWQgdG8gcmVzdWJtaXQgUlggVVJCOiAtMTkK
WyAgICAyLjYwMzk1N10gZGxuMiAxLTI6MS4wOiBub256ZXJvIHVyYiBzdGF0dXMgcmVjZWl2ZWQg
LTcxClsgICAgMi42MDM5NThdIGRsbjIgMS0yOjEuMDogZmFpbGVkIHRvIHJlc3VibWl0IFJYIFVS
QjogLTE5ClsgICAgMi42MDM5OTddIGRsbjIgMS0yOjEuMDogbm9uemVybyB1cmIgc3RhdHVzIHJl
Y2VpdmVkIC03MQpbICAgIDIuNjAzOTk4XSBkbG4yIDEtMjoxLjA6IGZhaWxlZCB0byByZXN1Ym1p
dCBSWCBVUkI6IC0xOQpbICAgIDIuNjc0MDIyXSBkbG4yOiBwcm9iZSBvZiAxLTI6MS4wIGZhaWxl
ZCB3aXRoIGVycm9yIC0xMTAKWyAgICAyLjY3NDA1N10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcg
aW50ZXJmYWNlIGRyaXZlciBkbG4yClsgICAgMi45Nzc5NTldIHVzYiAxLTI6IG5ldyBmdWxsLXNw
ZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDcgdXNpbmcgeGhjaV9oY2QKWyAgICAzLjExOTEwOF0gdXNi
IDEtMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPWEyNTcsIGlkUHJvZHVjdD0yMDEz
ClsgICAgMy4xMTkxMDldIHVzYiAxLTI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQ
cm9kdWN0PTIsIFNlcmlhbE51bWJlcj0wClsgICAgMy4xMTkxMTBdIHVzYiAxLTI6IFByb2R1Y3Q6
IERpb2xhbiBETE4yClsgICAgMy4xMTkxMTFdIHVzYiAxLTI6IE1hbnVmYWN0dXJlcjogRGlvbGFu
ClsgICAgMy4xMTk3NzRdIGRsbjIgMS0yOjEuMDogRGlvbGFuIERMTjIgc2VyaWFsIDMzNjI4ODQ0
Cgo=
--001a113cdd32391a450553ac6d89--
